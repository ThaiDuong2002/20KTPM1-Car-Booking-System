import s2sphere
print(dir(s2sphere.CellId))

def find_nearest_driver(customer_lat, customer_lng, drivers):
    # Tạo LatLng cho khách hàng
    customer_latlng = s2sphere.LatLng.from_degrees(customer_lat, customer_lng)

    # Lấy CellId của khách hàng tại một level cụ thể (ví dụ: level 13)
    customer_cell_id = s2sphere.CellId.from_lat_lng(customer_latlng).parent(13)

    # Lưu trữ khoảng cách tối thiểu và tài xế gần nhất
    min_distance = float('inf')
    nearest_driver = None

    # Duyệt qua danh sách tài xế
    for driver in drivers:
        driver_latlng = s2sphere.LatLng.from_degrees(
            driver['lat'], driver['lng'])
        driver_cell_id = s2sphere.CellId.from_lat_lng(driver_latlng).parent(13)

        # Tính khoảng cách giữa khách hàng và tài xế dựa trên cell_id
        distance = customer_cell_id.contains(driver_cell_id)

        # distance= customer_cell_id.GetCommonAncestorLevel()[0]
        # Cập nhật tài xế gần nhất
        if distance < min_distance:
            min_distance = distance
            nearest_driver = driver

    return nearest_driver


# Danh sách mẫu của tài xế
drivers = [
    {'name': 'Driver A', 'lat': 10.7630, 'lng': 106.6825},
    {'name': 'Driver B', 'lat': 10.7640, 'lng': 106.6830},
    {'name': 'Driver C', 'lat': 10.7650, 'lng': 106.6840},
]

# Tọa độ mẫu của khách hàng
customer_lat = 10.7629
customer_lng = 106.6824

# Tìm tài xế gần nhất
nearest_driver = find_nearest_driver(customer_lat, customer_lng, drivers)
print(f"The nearest driver is: {nearest_driver['name']}")
