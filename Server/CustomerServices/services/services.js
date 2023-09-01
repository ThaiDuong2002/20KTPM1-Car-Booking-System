import {User, Customer} from '../models/UserModel.js'
import Address from '../models/AddressModel.js'

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
    async saveAddress(user_id, address_id) {
        const result = await Customer.findByIdAndUpdate(
            user_id,
            {
                $push: {
                    address: address_id
                }
            },
            {new: true}
        )
        return result
    }
}

const AddressService = {
    async getAddressById(address_id) {
        const address = await Address.findById(address_id);
        return address
    },
    async get_user_addresses(user_id, filter, projection) {
        const result = await Address.find({
            userId: user_id,
            ...filter
        }).select(projection)
        return result
    },
    async addAddress(data) {
        const address = new Address(data)
        return await address.save()
    },
    async updateAddress(address_id, data) {
        const result = await Address.findByIdAndUpdate(
            address_id,
            data,
            {new: true}
        );
        return result
    },
    async deleteAddress(address_id) {
        return await Address.findByIdAndDelete(address_id);
    }
}

export {
    UserService,
    CustomerService,
    AddressService,
}
