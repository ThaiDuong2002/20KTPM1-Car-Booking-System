import createError from 'http-errors';
import bcryptjs from 'bcryptjs';
import {Consultant, Customer, Driver, User} from '../models/UserModel.js'
import vehicleServices from "./vehicleServices.js";

const projection = {
    password: 0,
    refreshToken: 0,
    __v: 0,
};

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
    async getUserById(user_id, filter) {
        const result = await User.findOne({
            _id: user_id,
            ...filter
        });
        return result
    },
    async updateUser(user_id, data) {
        const result = await User.findOneAndUpdate(
            {_id: user_id},
            data,
            {new: true}
        ).select(projection)
        return result
    },
    async createUser(userRole, data) {
        // Hash password
        const salt = bcryptjs.genSaltSync(10)
        data.password = bcryptjs.hashSync(data.password, salt)

        // Create new user
        let newUser
        switch (userRole) {
            case "customer":
                data.userRole = "customer"
                newUser = new Customer(data)
                break
            case "consultant":
                data.userRole = "consultant"
                newUser = new Consultant(data)
                break
            case "driver":
                // Create new vehicle
                const newVehicleId = await vehicleServices.createVehicle(data.vehicle)

                // Create new driver
                data.userRole = "driver"
                data.vehicleId = newVehicleId
                newUser = new Driver(data)
                break
            default:
                throw createError.BadRequest("Invalid role")
        }
        const result = await newUser.save()
        if (!result) {
            throw createError.BadRequest("Failed to save new user to the database");
        }
        return result
    }
}

export default UserService
