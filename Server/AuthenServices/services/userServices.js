import createError from 'http-errors';
import bcryptjs from 'bcryptjs';
import { 
    AdminFactory,
    CustomerFactory,
    DriverFactory,
    ConsultantFactory, 
} from '../models/UserFactory.js';
import { UserModel } from '../schemas/UserSchema.js'
import VehicleServices from './vehicleServices.js';


const projection = {
    password: 0,
    refreshToken: 0,
    __v: 0,
};

const UserService = {
    async getUserByIdentifier(email, phone) {
        const result = await UserModel.findOne({
            $or: [
                {email: email},
                {phone: phone}
            ]
        });
        return result
    },
    async getUserById(user_id, filter) {
        const result = await UserModel.findOne({
            _id: user_id,
            ...filter
        });
        return result
    },
    async updateUser(user_id, data) {
        const result = await UserModel.findOneAndUpdate(
            {_id: user_id},
            data,
            {new: true}
        ).select(projection)
        return result
    },
    async createUser(userInfo) {
        // Hash password
        const salt = bcryptjs.genSaltSync(10)
        userInfo.password = bcryptjs.hashSync(userInfo.password, salt)

        let newUser;

        switch (userInfo.userRole) {
            case 'admin':
                newUser = new AdminFactory().createUser(userInfo)
                break;
            case 'customer':
                newUser = new CustomerFactory().createUser(userInfo)
                break;
            case 'driver':
                // Create vehicle
                const newVehicle = await VehicleServices.createVehicle(userInfo.vehicle)
                // Add vehicle id to user info
                userInfo.vehicleId = newVehicle._id
                // Create driver
                newUser = new DriverFactory().createUser(userInfo);
                break;
            case 'consultant':
                newUser = new ConsultantFactory().createUser(userInfo);
                break;
            default:
                throw new Error(`Invalid user role: ${userInfo.userRole}`);
        }
        
        // Save to DB
        return await newUser.saveToDB();
    },
}

export default UserService
