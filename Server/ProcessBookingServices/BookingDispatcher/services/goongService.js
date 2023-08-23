import axios from "axios";
import dotenv from "dotenv";
import process from "process";

dotenv.config();
const config = process.env;

class GoongService {
    async getDriverDistanceList(origin_x, origin_y, trip_type, drivers_location) {
        let destination_str = "";
        for (let location of drivers_location) {
            destination_str += `${location.latitude},${location.longitude}|`;
        }
        // Remove the trailing '|' character
        destination_str = destination_str.slice(0, -1);

        const url = `${config.GOONG_DISTANCE_MATRIX_API_URL}?origins=${origin_x},${origin_y}&destinations=${destination_str}&vehicle=${trip_type}&api_key=${config.GOONG_API_KEY}`;
        try {
            const response = await axios.get(url);
            let drivers_distance_list = response.data.rows[0].elements;

            // Add driver id to the list
            for (let i = 0; i < drivers_distance_list.length; i++) {
                drivers_distance_list[i].id = drivers_location[i].id;
            }

            // Sort the list by distance
            drivers_distance_list.sort((a, b) => {
                return a.distance.value - b.distance.value;
            });

            return drivers_distance_list;
        } catch (error) {
            console.log('Error in getDriverDistanceList:', error)
            return null;
        }
    }
}

export default GoongService;