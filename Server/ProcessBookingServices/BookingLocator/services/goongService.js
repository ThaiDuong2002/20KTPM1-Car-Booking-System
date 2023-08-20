import axios from "axios";
import dotenv from "dotenv";

dotenv.config();
const config = process.env;

class GoongService {
    async getPlaceCoordinates(address) {
        console.log("Goong service used")
        try {
            const coordinates = await axios.get(
                config.GOONG_GEO_CODE_URL, {
                    params: {
                        address: address,
                        api_key: config.GOONG_API_KEY,
                    },
                }
            );
            return coordinates.data.results
        } catch (error) {
            throw new Error(error);
        }
    }
}

export default GoongService;