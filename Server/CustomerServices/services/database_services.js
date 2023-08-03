import User from '../models/User.model.js'
import Customer from '../models/Customer.model.js'

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
        const result = await User.findByIdAndUpdate(
            user_id,
            data,
            {new: true}
        )
        return result
    },
}

const CustomerService = {
    async updateCustomer(user_id, data, projection) {
        const result = await Customer.findByIdAndUpdate(
            user_id,
            data,
            {new: true}
        ).select(projection)
        return result
    },
}

export {
    UserService,
    CustomerService,
}
