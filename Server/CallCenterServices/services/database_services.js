import User from '../models/User.js'
import dotenv from 'dotenv';
import axios from 'axios'

dotenv.config();

const UserService = {
    async getUserByIdentifier(email, phone) {
        const result = await User.findOne({
            $or: [
                { email: email },
                { phone: phone }
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
            { _id: user_id },
            data,
            { new: true }
        )
        return result
    },
}

const CallcenterService = {
    async booking(booking_info) {
        try {
            // Call booking service
            const url = process.env.BOOKING_SERVICE_URI
            const response = await axios.post(url, booking_info)
            return response.data
        } catch (error) {
            throw error
        }
    },
}

export {
    UserService,
    CallcenterService,
}
