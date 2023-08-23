import axios from "axios";
import dotenv from "dotenv";

dotenv.config();

const config = process.env

class GoogleService {
    async getPlaceCoordinates(address) {
        console.log("Google service used")
        try {
            const coordinates = await axios.get(
                config.GOOGLE_TEXT_SEARCH_URL, {
                    params: {
                        query: address,
                        key: config.GOOGLE_MAPS_API_KEY,
                    },
                });
            return coordinates.data.results;
        } catch (error) {
            throw new Error(error);
        }
    }
}

export default GoogleService;