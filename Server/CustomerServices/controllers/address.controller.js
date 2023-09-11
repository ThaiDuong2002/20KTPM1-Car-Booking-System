import createError from "http-errors";
import {
    UserService,
    CustomerService,
    AddressService,
} from "../services/services.js";

const AddressController = {
    get_addresses: async (req, res, next) => {
        try {
            const user_id = req.headers['x-user-id']
            const filter = req.body
            const projection = {
                name: 1,
                formattedAddress: 1,
                type: 1,
            }
            const user = await UserService.getUserById(user_id)
            if (!user) {
                return next(createError.BadRequest("User not found"))
            }
            const saved_addresses = await AddressService.get_user_addresses(user_id, filter, projection)

            if (!saved_addresses) {
                return next(createError.BadRequest("Get addresses failed"))
            }
            res.json({
                message: "Get addresses successfully",
                status: 200,
                data: saved_addresses
            })
        } catch (error) {
            next(createError.InternalServerError(error.message))
        }
    },
    get_address_details: async (req, res, next) => {
        try {
            const address_id = req.params.id
            const address = await AddressService.getAddressById(address_id)
            if (!address) {
                return next(createError.BadRequest("Address not found"))
            }
            res.json({
                message: "Get address details successfully",
                status: 200,
                data: address
            })
        } catch (error) {
            next(createError.InternalServerError(error.message))
        }
    },
    save_address: async (req, res, next) => {
        try {
            const user_id = req.headers['x-user-id']
            const address = req.body
            const user = await UserService.getUserById(user_id)
            if (!user) {
                return next(createError.BadRequest("User not found"))
            }
            const address_data = {
                userId: user_id,
                ...address
            }
            const add_address_re = await AddressService.addAddress(address_data)
            if (!add_address_re) {
                return next(createError.BadRequest("Add address failed"))
            }
            const update_address_re = await CustomerService.saveAddress(user_id, add_address_re._id)
            if (!update_address_re) {
                return next(createError.BadRequest("Save address of customer failed"))
            }
            res.json({
                message: "Save address successfully",
                status: 200,
                data: add_address_re
            })
        } catch (error) {
            next(createError.InternalServerError(error.message))
        }
    },
    edit_address: async (req, res, next) => {
        try {
            const address_id = req.params.id
            const update_field = req.body
            const address = await AddressService.getAddressById(address_id)
            if (!address) {
                return next(createError.BadRequest("Address not found"))
            }
            const updated_address = await AddressService.updateAddress(address_id, update_field)
            if (!updated_address) {
                return next(createError.BadRequest("Update address failed"))
            }
            res.json({
                message: "Update address successfully",
                status: 200,
                data: updated_address
            })
        } catch (error) {
            next(createError.InternalServerError(error.message))
        }
    },
    delete_address: async (req, res, next) => {
        try {
            const address_id = req.params.id
            const address = await AddressService.getAddressById(address_id)
            if (!address) {
                return next(createError.BadRequest("Address not found"))
            }
            const deleted_address = await AddressService.deleteAddress(address_id)
            if (!deleted_address) {
                return next(createError.BadRequest("Delete address failed"))
            }
            res.json({
                message: "Delete address successfully",
                status: 200,
                data: deleted_address
            })
        } catch (error) {
            next(createError.InternalServerError(error.message))
        }
    },
}

export default AddressController;