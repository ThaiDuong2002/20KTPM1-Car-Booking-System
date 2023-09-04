import os
import requests
import json
from flask import Flask, jsonify, request
import s2sphere
import redis
from dotenv import load_dotenv

load_dotenv()

API_KEY = os.getenv("GOONG_API_KEY")
REDIS_URI = os.getenv("REDIS_URI")

redis_client = redis.from_url(REDIS_URI)
# redis_client.flushdb()

app = Flask(__name__)


def retrieve_drivers_location():
    all_keys = redis_client.keys('driver*')

    if not all_keys:
        return []

    # Use the MGET command to retrieve values associated with the keys
    driver_locations = redis_client.mget(all_keys)

    # Parse the JSON strings back to objects
    parsed_driver_locations = []
    for location in driver_locations:
        if location is not None:
            parsed_driver_locations.append(json.loads(location.decode('utf-8')))

    return parsed_driver_locations


# def generate_random_driver(base_lat, base_lng, driver_id):
#     """Tạo tọa độ ngẫu nhiên cho tài xế dựa trên tọa độ cơ sở."""
#     random_lat = base_lat + random.uniform(-0.01, 0.01)
#     random_lng = base_lng + random.uniform(-0.01, 0.01)
#     return {"name": f"Driver {driver_id}", "lat": random_lat, "lng": random_lng, "trip_type": "car"}
#
# drivers = [
#     {"name": "Driver 1", "lat": 10.760705456873508,
#         "lng": 106.68172029261463, "trip_type": "car"},
#     {"name": "Driver 2", "lat": 10.766427594910402,
#         "lng": 106.68242978340015, "trip_type": "car"},
#     {"name": "Driver 3", "lat": 10.762827795411908,
#         "lng": 106.67605254000351, "trip_type": "car"},
#     {"name": "Driver 4", "lat": 10.755743736320355,
#         "lng": 106.68186962178058, "trip_type": "car"},
# ]
#
# # Tạo 15 tài xế ngẫu nhiên dựa trên dữ liệu ban đầu
# for i in range(5, 20):  # Bắt đầu từ tài xế thứ 5 đến tài xế thứ 19
#     base_driver = random.choice(drivers)
#     new_driver = generate_random_driver(
#         base_driver["lat"], base_driver["lng"], i)
#     drivers.append(new_driver)


def get_distance_and_duration(api_key, origins, destinations, vehicle="car"):
    """
    Lấy ma trận khoảng cách giữa các điểm origins và destinations.

    Tham số:
    - api_key: khóa API của bạn cho dịch vụ Goong
    - origins: chuỗi toạ độ điểm bắt đầu, ví dụ: "20.981971,105.864323"
    - destinations: chuỗi các toạ độ điểm đích, ví dụ: "21.031011,105.783206|21.022328,105.790480|21.016665,105.788774"
    - vehicle: loại phương tiện, mặc định là "car"

    Trả về:
    - data: ma trận khoảng cách nếu yêu cầu thành công
    - None: nếu yêu cầu thất bại
    """
    url = f"https://rsapi.goong.io/DistanceMatrix?origins={origins}&destinations={destinations}&vehicle={vehicle}&api_key={api_key}"
    response = requests.get(url)
    if response.status_code == 200:
        data = response.json()
        elements = data['rows'][0]['elements']
        if elements and len(elements) > 0:
            duration = elements[0]['duration']
            distance = elements[0]['distance']
            return {'distance': distance, 'duration': duration}
        return data
    else:
        print("Request failed with status code:", response.status_code)
        return None


@app.route('/find-drivers', methods=['POST'])
def find_drivers():
    # Nhận dữ liệu từ request
    drivers = retrieve_drivers_location()
    customer_lat = request.json.get('lat')
    customer_lng = request.json.get('lng')
    trip_type = request.json.get('trip_type')

    # Kiểm tra xem toạ độ của khách hàng có được cung cấp không
    if not customer_lat or not customer_lng:
        return jsonify({"error": "Customer coordinates not provided!"}), 400

    # Bắt đầu từ mức phân giải cao
    level_of_resolution = 13
    max_resolution = 11  # Giới hạn phân giải tối thiểu

    # Lọc ra các tài xế nằm trong khoảng
    drivers_inside_polygon = []
    drivers_inside_polygon_outside = []

    while not drivers_inside_polygon and level_of_resolution >= max_resolution:
        latlng = s2sphere.LatLng.from_degrees(customer_lat, customer_lng)
        cell_id = s2sphere.CellId.from_lat_lng(latlng).parent(level_of_resolution)
        range_min = cell_id.range_min().id()
        range_max = cell_id.range_max().id()

        # Lọc ra các tài xế trong phạm vi cell_id - Sử dụng redis ở đây
        for driver in drivers:
            driver_latlng = s2sphere.LatLng.from_degrees(
                driver['lat'], driver['lng'])
            driver_cell_id = s2sphere.CellId.from_lat_lng(driver_latlng).id()

            if (range_min <= driver_cell_id <= range_max) and driver['trip_type'] == trip_type:
                drivers_inside_polygon.append(driver)
            else:
                drivers_inside_polygon_outside.append(driver)

        level_of_resolution -= 1

    # implement mapping algorithm here
    if len(drivers_inside_polygon) <= 0:
        # Trả về tài xế gần nhất
        return jsonify({
            'driver': [],
            'message': 'No drivers found!'

        })

    # mapping algorithm driver for customer using ETA
    if drivers_inside_polygon:
        def get_duration_from_customer(driver):
            destinations = "{},{}".format(driver['lat'], driver['lng'])
            origins = "{},{}".format(customer_lat, customer_lng)

            rs = get_distance_and_duration(
                API_KEY, origins, destinations, trip_type)

            # Kiểm tra xem rs có giá trị không và sau đó truy xuất thời gian đi.
            if rs and 'duration' in rs and 'value' in rs['duration']:
                return rs['duration']['value']
            else:
                return float('inf')

    # sort by duration
    drivers_inside_polygon.sort(key=get_duration_from_customer)

    return jsonify({
        'drivers_inside_sorted': drivers_inside_polygon,
        'drivers_outside': drivers_inside_polygon_outside,
        'cid': level_of_resolution + 1
    })


@app.route('/redis-health-check', methods=['GET'])
def check_redis():
    try:
        result = redis_client.ping()
        return {'message': 'Redis is running', 'result': result}
    except Exception as e:
        return {'message': 'Error connecting to Redis', 'error': str(e)}


# Route to get all driver locations
@app.route('/driver_locations', methods=['GET'])
def get_driver_locations():
    try:
        # Use the KEYS command to get all keys that match the pattern (e.g., all keys)
        all_keys = redis_client.keys('driver*')

        if not all_keys:
            return {'data': []}

        # Use the MGET command to retrieve values associated with the keys
        driver_locations = redis_client.mget(all_keys)

        # Parse the JSON strings back to objects
        parsed_locations = []
        for location in driver_locations:
            if location is not None:
                parsed_locations.append(json.loads(location.decode('utf-8')))

        return {'data': parsed_locations}

    except Exception as e:
        return {'error': str(e)}


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=3000)
