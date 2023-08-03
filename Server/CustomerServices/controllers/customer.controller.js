import createError from "http-errors";
import {
    UserService,
    CustomerService,
} from "../services/database_services.js";
import Customer from "../models/Customer.model.js";

const CustomerController = {
    me: async (req, res, next) => {
        try {
            const customer_id = req.headers['x-user-id']

            const result = await UserService.getUserById(customer_id, {}, '-_id -password -refreshToken')

            if (!result) {
                return next(createError.BadRequest("customer not found"))
            }
            res.json({
                message: "Get customer's info successfully",
                status: 200,
                data: result
            })
        } catch (error) {
            next(createError.BadRequest(error.message))
        }
    },
    edit_info: async (req, res, next) => {
        try {
            const customer_id = req.headers['x-user-id']
            const update_info = req.body
            if (update_info.password || update_info.__t || update_info.email || update_info.phone || update_info.role) {
                return next(createError.BadRequest("Invalid update fields"))
            }

            const result = await UserService.updateUser(customer_id, update_info, '-_id -password -refreshToken')

            if (!result) {
                return next(createError.BadRequest("customer not found"))
            }
            res.json({
                message: "Update customer's info successfully",
                status: 200,
                data: result
            })
        } catch (error) {
            next(createError.BadRequest(error.message))
        }
    },
    logout: async (req, res, next) => {
        try {
            const user_id = req.headers['x-user-id']
            const user = await UserService.getUser({
                _id: user_id,
                refreshToken: ""
            })
            if (user) {
                return next(createError.BadRequest("User already logged out"))
            }
            const updatedUser = await UserService.updateUser(user_id, {refreshToken: ''})
            if (!updatedUser) {
                return next(createError.BadRequest("Update failed"))
            }
            res.json({
                message: "Logout successfully",
                status: 200,
                data: {}
            })
        } catch (error) {
            next(createError.BadRequest(error.message))
        }
    },
    upgrade: async (req, res, next) => {
        try {
            const user_id = req.headers['x-user-id']
            const user = await UserService.getUserById(user_id)
            if (!user) {
                return next(createError.BadRequest("User not found"))
            }
            if (user.userType === "premium") {
                return next(createError.Conflict("User already upgraded"))
            }
            const updatedUser = await CustomerService.updateCustomer(
                user_id,
                {userType: "premium"},
                '-_id -password -refreshToken')
            if (!updatedUser) {
                return next(createError.BadRequest("Upgrade failed"))
            }
            res.json({
                message: "Upgrade successfully",
                status: 200,
                data: updatedUser
            })
        } catch (error) {
            next(createError.BadRequest(error.message))
        }
    },
};

export default CustomerController;
