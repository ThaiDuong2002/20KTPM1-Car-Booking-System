import createError from 'http-errors';
import {create_booking_schema, update_booking_schema} from '../middlewares/validate.js';
import {BookingService, UserService} from '../services/database_services.js';

const BookingController = {
    async add_booking(req, res, next) {
        try {
            const {error, value} = create_booking_schema.validate(req.body);
            if (error) {
                return next(createError.BadRequest(error.details[0].message))
            }
            let booking_data = value
            // Validate driver
            const driver = UserService.get_user_by_id(booking_data.driver_id);
            if (!driver) {
                return next(createError.BadRequest("User not found"));
            }
            const user_id = req.headers['x-user-id']
            // If the user is anonymous, set user_id to null
            if (!user_id) {
                booking_data.user_id = null
            } else {
                booking_data.user_id = user_id
            }
            // Create booking
            const booking_re = await BookingService.create_booking(booking_data);
            res.status(201).json({
                message: 'Create booking successfully',
                status: 200,
                data: booking_re,
            })
        } catch (err) {
            next(createError.InternalServerError(err.message));
        }
    },
    async get_booking_details(req, res, next) {
        try {
            const booking_id = req.params.id
            const booking = await BookingService.get_booking_details(booking_id);
            if (!booking) {
                return next(createError.NotFound("Booking not found"));
            }
            res.json({
                message: 'Get booking details successfully',
                status: 200,
                data: booking,
            })
        } catch (err) {
            next(createError.InternalServerError(err.message));
        }
    },
    async get_booking_list(req, res, next) {
        try {
            let filter = req.body
            const list = await BookingService.get_bookings_list(filter);
            if (!list) {
                return next(createError.BadRequest("Get list failed"));
            }
            if (list.length == 0) {
                return next(createError.NotFound("No booking found"));
            }
            res.json({
                message: 'Get bookings list successfully',
                status: 200,
                data: list,
            })
        } catch (err) {
            next(createError.InternalServerError(err.message));
        }
    },
    async update_booking(req, res, next) {
        try {
            const booking_id = req.params.id
            const {error, value} = update_booking_schema.validate(req.body);
            if (error) {
                return next(createError.BadRequest(error.details[0].message));
            }
            // Update booking
            const update_result = await BookingService.update_booking(booking_id, value);
            if (!update_result)
            {
                return res.status(404).json({
                    message: 'Booking not found',
                    status: 404,
                })
            }
            res.status(200).json({
                message: 'Update booking successfully',
                status: 200,
                data: update_result,
            })
        } catch (err) {
            next(createError.InternalServerError(err.message));
        }
    },
    async delete_booking(req, res, next){
        try {
            const booking_id = req.params.id
            // Delete promotion
            const delete_result = await BookingService.delete_booking(booking_id);
            if (!delete_result)
            {
                return res.status(404).json({
                    message: 'Booking not found',
                    status: 404,
                })
            }
            res.status(200).json({
                message: 'Delete promotion successfully',
                status: 200,
                data: delete_result,
            })
        } catch (err) {
            next(createError.InternalServerError(err.message));
        }
    }
}

export default BookingController;