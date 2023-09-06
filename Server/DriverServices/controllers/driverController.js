import createError from "http-errors";
import {UserService, DriverService} from "../services/services.js";

const DriverController = {
    me: async (req, res, next) => {
        try {
            const driver_id = req.headers['x-user-id']

            const result = await UserService.getUserById(driver_id, {}, '-_id -password -refreshToken')

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
    get_my_vehicle: async (req, res, next) => {
        try {
            const driver_id = req.headers['x-user-id']

            const result = await DriverService.getDriverVehicle(driver_id)

            if (!result) {
                return next(createError.BadRequest("driver not found"))
            }

            res.json({
                message: "Get driver's vehicle successfully",
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

            const result = await UserService.updateUser(driver_id, update_info, '-_id -password -refreshToken')

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
    update_location: async (req, res, next) => {
        try {
            const driverId = req.headers['x-user-id']
            const {lat, lng, tripType} = req.body
            await DriverService.updateDriverLocationToRedis(driverId, lat, lng, tripType)
            res.json({
                message: "Update driver's location successfully",
                status: 200,
                data: []
            })
        } catch (error) {
            next(createError.BadRequest(error.message))
        }
    },
    get_driver_locations: async (req, res, next) => {
        try {
            const driverLocations = await DriverService.getDriverLocations();
            if(!driverLocations) {
                return next(createError.BadRequest("No drivers found"))
            }
            res.status(200).json({
                message: "Get driver's locations successfully",
                status: 200,
                data: driverLocations
            });
        } catch (error) {
            next(createError.BadRequest(error.message))
        }
    }
};

export default DriverController;
