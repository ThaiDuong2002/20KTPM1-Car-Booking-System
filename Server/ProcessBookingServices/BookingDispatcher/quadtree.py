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
customer = {"name": "Customer",
            "lat": 10.762975750529066, "lng": 106.68248073637325}

# Tạo 15 tài xế ngẫu nhiên dựa trên dữ liệu ban đầu
for i in range(5, 20):  # Bắt đầu từ tài xế thứ 5 đến tài xế thứ 19
    base_driver = random.choice(drivers)
    new_driver = generate_random_driver(
        base_driver["lat"], base_driver["lng"], i)
    drivers.append(new_driver)

class QuadtreeNode:
    def __init__(self, boundary, depth=0, max_depth=4, max_elements=4):
        self.boundary = boundary  # A rectangle
        self.drivers = []
        self.NW = None
        self.NE = None
        self.SW = None
        self.SE = None
        self.depth = depth
        self.max_depth = max_depth
        self.max_elements = max_elements

    def insert(self, driver):
        if not self.boundary.contains(driver):
            return False

        if len(self.drivers) < self.max_elements or self.depth == self.max_depth:
            self.drivers.append(driver)
            return True

        if self.NW is None:
            self.subdivide()

        if self.NW.insert(driver):
            return True
        if self.NE.insert(driver):
            return True
        if self.SW.insert(driver):
            return True
        if self.SE.insert(driver):
            return True

    def subdivide(self):
        depth = self.depth + 1
        mid_lat = (self.boundary.min_lat + self.boundary.max_lat) / 2
        mid_lng = (self.boundary.min_lng + self.boundary.max_lng) / 2

        nw_boundary = Rectangle(self.boundary.min_lat,
                                mid_lat, self.boundary.min_lng, mid_lng)
        self.NW = QuadtreeNode(
            nw_boundary, depth, self.max_depth, self.max_elements)

        ne_boundary = Rectangle(self.boundary.min_lat,
                                mid_lat, mid_lng, self.boundary.max_lng)
        self.NE = QuadtreeNode(
            ne_boundary, depth, self.max_depth, self.max_elements)

        sw_boundary = Rectangle(
            mid_lat, self.boundary.max_lat, self.boundary.min_lng, mid_lng)
        self.SW = QuadtreeNode(
            sw_boundary, depth, self.max_depth, self.max_elements)

        se_boundary = Rectangle(
            mid_lat, self.boundary.max_lat, mid_lng, self.boundary.max_lng)
        self.SE = QuadtreeNode(
            se_boundary, depth, self.max_depth, self.max_elements)


class Rectangle:
    def __init__(self, min_lat, max_lat, min_lng, max_lng):
        self.min_lat = min_lat
        self.max_lat = max_lat
        self.min_lng = min_lng
        self.max_lng = max_lng

    def contains(self, driver):
        return (self.min_lat <= driver['lat'] <= self.max_lat and
                self.min_lng <= driver['lng'] <= self.max_lng)

    def intersects(self, rect):
        return not (rect.min_lng > self.max_lng or
                rect.max_lng < self.min_lng or
                rect.min_lat > self.max_lat or
                rect.max_lat < self.min_lat)


# Using the Quadtree for the given code:

def build_quadtree(drivers, boundary, max_depth=4, max_elements=4):
    root = QuadtreeNode(boundary, max_depth=max_depth,
                        max_elements=max_elements)
    for driver in drivers:
        root.insert(driver)
    return root


def query_quadtree(quadtree, boundary):
    if quadtree is None or not boundary.intersects(quadtree.boundary):
        return []

    drivers_within_boundary = [
        driver for driver in quadtree.drivers if boundary.contains(driver)]

    if quadtree.NW:
        drivers_within_boundary += query_quadtree(quadtree.NW, boundary)
    if quadtree.NE:
        drivers_within_boundary += query_quadtree(quadtree.NE, boundary)
    if quadtree.SW:
        drivers_within_boundary += query_quadtree(quadtree.SW, boundary)
    if quadtree.SE:
        drivers_within_boundary += query_quadtree(quadtree.SE, boundary)

    return drivers_within_boundary



# Example:
# Assuming this is the boundary for all drivers
boundary = Rectangle(10.75, 10.78, 106.675, 106.69)
quadtree = build_quadtree(drivers, boundary)
# print(quadtree.drivers)
# Querying the quadtree for nearby drivers (using a smaller boundary for the customer)
customer_boundary = Rectangle(customer['lat'] - 0.005, customer['lat'] + 0.005,
                              customer['lng'] - 0.005, customer['lng'] + 0.005)
# print(quadtree.drivers)
nearby_drivers = query_quadtree(quadtree, customer_boundary)
print(nearby_drivers)
