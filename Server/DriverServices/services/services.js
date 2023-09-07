import {User, Driver} from '../models/UserModel.js'
import {Vehicle} from  '../models/VehicleModel.js'
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
    async updateDriverLocationToRedis (driverId, lat, lng, tripType) {
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
    async getVehicleById (vehicleId) {
        const vehicle = await Vehicle.findById(vehicleId);
        return vehicle;
    },
    async updateVehicle (vehicleId, update_fields) {
        const updatedVehicle = await Vehicle.findByIdAndUpdate(vehicleId, update_fields, {new: true});
        return updatedVehicle
    },
    async getVehicleTypeList (filter, projection) {
        const result = await VehicleType.find(filter).select(projection);
        return result;
    },
    async getVehicleType (id) {
        const result = await VehicleType.findById(id);
        return result
    },
    async addVehicleType (name, capacity) {
        const vehicleType = new VehicleType({
            name: name,
            capacity: capacity,
        });
        const result = await vehicleType.save();
        return result;
    },
    async updateVehicleType (id, name, capacity) {
        const result = await VehicleType.findByIdAndUpdate(id, {
            name: name,
            capacity: capacity,
        }, {new: true});
        return result;
    },
    async deleteVehicleType (id) {
        const result = await VehicleType.findByIdAndDelete(id);
        return result;
    }
}

export {
    UserService,
    DriverService,
    VehicleService,
}
