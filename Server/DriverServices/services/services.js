import {User} from '../models/UserModel.js'
import {VehicleType} from '../models/VehicleTypeModel.js'
import {redis} from '../configs/db.js'

const UserService = {
    async getUserByIdentifier(email, phone) {
        const result = await User.findOne({
            $or: [
                {email: email},
                {phone: phone}
            ]
        });
        return result
    },
    async getUserById(user_id, filter, projection) {
        const result = await User.findOne({
                _id: user_id,
                ...filter
            }
        ).select(projection)
        return result
    },
    async getUser(filter) {
        const result = await User.findOne(filter)
        return result
    },
    async updateUser(user_id, data) {
        const result = await User.findOneAndUpdate(
            {_id: user_id},
            data,
            {new: true}
        )
        return result
    },
};

const DriverService = {
    async updateDriverLocationToRedis(driverId, lat, lng, tripType) {
        const data_json_string = JSON.stringify({driverId, lat, lng, tripType});
        console.log(data_json_string)
        await redis.set(driverId, data_json_string);
    },
    async getDriverLocations () {
        // Use the KEYS command to get all keys that match the pattern (e.g., all keys)
        const allKeys = await redis.keys('*');

        if (!allKeys || allKeys.length === 0) {
            return [];
        }

        // Use the MGET command to retrieve values associated with the keys
        const driverLocations = await redis.mget(...allKeys);

        // Parse the JSON strings back to objects
        return driverLocations.map((location) => JSON.parse(location));
    }
}

const VehicleService = {
    async getVehicleTypeList () {
        const result = await VehicleType.find();
        return result;
    }
}

export {
    UserService,
    DriverService,
    VehicleService,
}
