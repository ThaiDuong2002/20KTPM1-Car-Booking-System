import createError from "http-errors";
import UserService from "../services/database_services.js";

const DriverController = {
    me: async (req, res, next) => {
        try {
            const driver_id = req.headers['x-user-id']

            const result = await UserService.getUserById(driver_id, {}, '-_id firstname lastname email phone avatar dob gender')

            if (!result) {
                return next(createError.BadRequest("driver not found"))
            }
            res.json({
                message: "Get driver's info successfully",
                status: 200,
                data: result
            })
        } catch (error) {
            next(createError.BadRequest(error.message))
        }
    },
    edit_info: async (req, res, next) => {
        try {
            const driver_id = req.headers['x-user-id']
            const update_info = req.body
            if (update_info.password || update_info.__t || update_info.email || update_info.phone) {
                return next(createError.BadRequest("Invalid update fields"))
            }

            const result = await UserService.updateUser(driver_id, update_info, '-_id firstname lastname email phone avatar dob gender')

            if (!result) {
                return next(createError.BadRequest("driver not found"))
            }
            res.json({
                message: "Update driver's info successfully",
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
            console.log(user)
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
};

export default DriverController;
