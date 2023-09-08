import webbrowser
from shapely.geometry import Point, Polygon
import s2sphere


import random


def generate_random_driver(base_lat, base_lng, driver_id):
    """Tạo tọa độ ngẫu nhiên cho tài xế dựa trên tọa độ cơ sở."""
    random_lat = base_lat + random.uniform(-0.01, 0.01)
    random_lng = base_lng + random.uniform(-0.01, 0.01)
    return {"name": f"Driver {driver_id}", "lat": random_lat, "lng": random_lng}


# Dữ liệu ban đầu
drivers = [
    {"name": "Driver 1", "lat": 10.760705456873508, "lng": 106.68172029261463},
    {"name": "Driver 2", "lat": 10.766427594910402, "lng": 106.68242978340015},
    {"name": "Driver 3", "lat": 10.762827795411908, "lng": 106.67605254000351},
    {"name": "Driver 4", "lat": 10.755743736320355, "lng": 106.68186962178058},
]

# Tạo 15 tài xế ngẫu nhiên dựa trên dữ liệu ban đầu
for i in range(5, 20):  # Bắt đầu từ tài xế thứ 5 đến tài xế thứ 19
    base_driver = random.choice(drivers)
    new_driver = generate_random_driver(
        base_driver["lat"], base_driver["lng"], i)
    drivers.append(new_driver)

def s2_cell_to_gmap_polygon(cell):
    vertices = []
    for i in range(4):
        vertex = cell.get_vertex(i)
        latlng = s2sphere.LatLng.from_point(vertex)
        vertices.append({"lat": latlng.lat().degrees,
                        "lng": latlng.lng().degrees})
    return vertices

customer = {"name": "Customer",
            "lat": 10.762975750529066, "lng": 106.68248073637325}

# Tạo một S2 cell ở mức 10 với trung tâm là Trường đại học khoa học tự nhiên 
latlng = s2sphere.LatLng.from_degrees(10.762975750529066,106.68248073637325)

cell_id = s2sphere.CellId.from_lat_lng(latlng).parent(13)

cell = s2sphere.Cell(cell_id)
polygon_vertices = s2_cell_to_gmap_polygon(cell)
polygon = Polygon([(vertex["lat"], vertex["lng"])
                  for vertex in polygon_vertices])
    

range_min = cell_id.range_min().id()
range_max = cell_id.range_max().id()



# Lọc ra các tài xế nằm trong khoảng
drivers_inside_polygon = []
drivers_inside_polygon_outside = []
for driver in drivers:
    driver_latlng = s2sphere.LatLng.from_degrees(driver['lat'], driver['lng'])
    driver_cell_id = s2sphere.CellId.from_lat_lng(driver_latlng).id()

    if range_min <= driver_cell_id <= range_max:
        drivers_inside_polygon.append(driver)

    else:
        drivers_inside_polygon_outside.append(driver)

# # Lọc ra các tài xế nằm trong đa giác
# drivers_inside_polygon = [driver for driver in drivers if polygon.contains(
#     Point(driver["lat"], driver["lng"]))]

# # Vẽ ra các tài xế nằm nằm ngoài đa giác
# drivers_inside_polygon_outside = [driver for driver in drivers if not polygon.contains(
#     Point(driver["lat"], driver["lng"]))]

# Tạo HTML
gmap_template = f"""
<html>
  <head>
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDegGs0gQhRVn5osHdt_hOmjwiXpjpJL9Q"></script>
    <script>
      function loadMap() {{
        var mapOptions = {{
            center: new google.maps.LatLng({polygon_vertices[0]["lat"]}, {polygon_vertices[0]["lng"]}),
            zoom: 12,
            mapTypeId: google.maps.MapTypeId.ROADMAP
        }};
        var map = new google.maps.Map(document.getElementById("map"), mapOptions);
        var polygonCoords = {polygon_vertices};
        var s2Polygon = new google.maps.Polygon({{
          paths: polygonCoords,
          strokeColor: "#FF0000",
          strokeOpacity: 0.8,
          strokeWeight: 2,
          fillColor: "#FF0000",
          fillOpacity: 0.35
        }});
        s2Polygon.setMap(map);

        var customer = {customer};
        var customerMarker = new google.maps.Marker({{
            position: new google.maps.LatLng(customer.lat, customer.lng),
            map: map,
            title: customer.name,
            icon: 'http://maps.google.com/mapfiles/ms/icons/blue-dot.png' // biểu tượng màu xanh
        }});

        var drivers = {drivers_inside_polygon};
        for (var i = 0; i < drivers.length; i++) {{
            var driver = drivers[i];
            var marker = new google.maps.Marker({{
                position: new google.maps.LatLng(driver.lat, driver.lng),
                map: map,
                title: driver.name
            }});
        }}
    

       var drivers_outside = {drivers_inside_polygon_outside};
        for (var i = 0; i < drivers_outside.length; i++) {{
            var driver = drivers_outside[i];
            var marker = new google.maps.Marker({{
                position: new google.maps.LatLng(driver.lat, driver.lng),
                map: map,
                title: driver.name
            }});
        }}
        }}
      

    </script>
  </head>
  <body onload="loadMap()">
    <div id="map" style="width:100%;height:800px;"></div>
  </body>
</html>
"""

with open("temp_map.html", "w") as f:
    f.write(gmap_template)

webbrowser.open_new_tab("temp_map.html")
