import Admin from '../models/Admin.js'

const AdminServices = {
    async getAllUsers(filter, projection) {
        const result = await Admin.find(filter).select(projection);
        return result
    },
    async getUserByIdentifier(email, phone) {
        const result = await Admin.findOne({
            $or: [
                { email: email },
                { phone: phone }
            ]
        });
        return result
    },
}

export default AdminServices
