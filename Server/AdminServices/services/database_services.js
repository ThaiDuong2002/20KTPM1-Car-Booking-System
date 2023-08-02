import User from '../models/User.js'

const AdminServices = {
    async getAllUsers(filter, projection) {
        return await User.find(filter).select(projection);
    },
}

export default AdminServices
