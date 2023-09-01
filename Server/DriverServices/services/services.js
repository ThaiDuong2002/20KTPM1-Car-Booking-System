import {User} from '../models/UserModel.js'

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

export default UserService
