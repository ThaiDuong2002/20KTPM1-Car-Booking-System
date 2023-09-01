import S2_GEO from 's2-geometry';
const S2 = S2_GEO.S2;
const closeDriverLat = 37.7749 + 0.01;
const closeDriverLng = -122.4194 + 0.01;
const closeDriverCellId = S2.latLngToKey(closeDriverLat, closeDriverLng, 12);

const list_of_drivers = [
    { id: 1, lat: 37.7749, lng: -122.4194, cell_id: "89c25b1b5646a477" },
    { id: 2, lat: 34.0522, lng: -118.2437, cell_id: "89c25b18c0575d8f" },
    { id: 3, lat: 40.7128, lng: -74.0060, cell_id: "89c25b258d69326f" },
    { id: 4, lat: closeDriverLat, lng: closeDriverLng, cell_id: closeDriverCellId },
    { id: 5, lat: 51.5074, lng: -0.1278, cell_id: "89c25b4be1c9c58f" },
    { id: 6, lat: 52.5200, lng: 13.4050, cell_id: "89c25b68c6b64c9f" },
    { id: 7, lat: 48.8566, lng: 2.3522, cell_id: "89c25b5ce9dbb3cf" },
    { id: 8, lat: 55.7558, lng: 37.6176, cell_id: "89c25b7be4b6d39f" },
    { id: 9, lat: -33.8688, lng: 151.2093, cell_id: "89c25b103d18807f" },
    { id: 10, lat: -22.9068, lng: -43.1729, cell_id: "89c25b35ca62215f" },
];

const customer = {
    id: 1, lat: 37.7749, lng: -122.4194
}

function getRandomOffset() {
    // Generate a random offset between -0.05 and 0.05 (adjust as needed)
    return (Math.random() - 0.5) * 0.1;
}

function findDriver() {
    try {
        const customer_lat = customer.lat;
        const customer_lng = customer.lng;

        // Convert customer coordinates to S2 Cell Key
        const customer_key = S2.latLngToKey(customer_lat, customer_lng, 12);

        // Get list of neighboring S2 Cell Keys
        const neighborKeys = S2.latLngToNeighborKeys(customer_lat, customer_lng, 12);
        // console.log(neighborKeys);
        // Filter driver list based on proximity
        const drivers_within_radius = list_of_drivers.filter(driver => {
            return driver.cell_id === customer_key || neighborKeys.includes(driver.cell_id);
        });

        return drivers_within_radius;
    } catch (error) {
        console.error(error);
        return [];
    }
}

console.log(findDriver());
