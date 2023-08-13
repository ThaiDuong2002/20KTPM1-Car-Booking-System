import createError from 'http-errors';
import {create_booking_schema, update_booking_schema} from '../middlewares/validate.js';
import {BookingService, UserService} from '../services/services.js';

const BookingController = {
    async add_booking(req, res, next) {
        try {
            const {error, value} = create_booking_schema.validate(req.body);
            if (error) {
                return next(createError.BadRequest(error.details[0].message))
            }
            // Validate driver
            const driver = await UserService.get_user_by_id(value.booking_driver_id);
            if (!driver) {
                return next(createError.BadRequest("Driver not exist"));
            }
            const user_info = {
                id: req.headers['x-user-id'],
                role: req.headers['x-user-role']
            }
            value.booking_user_id = user_info.id;
            // Create booking
            const booking_re = await BookingService.create_booking(value);
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
            const populateOptions = {
                "booking_user_id": '-password -refreshToken',
                "booking_driver_id": '-password -refreshToken',
                "trip_promotion_id": '',
                "booking_payment_method_id": '',
                "booking_refund_id": '',
                "booking_ratings.user_id": '_id firstname lastname email',
            };
            const booking = await BookingService.get_booking_details(booking_id, populateOptions);
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
            let projection = {
                createdAt: 1,
                customer_name: 1,
                customer_phone: 1,
                trip_pickup_location: 1,
                trip_destination_location: 1,
                trip_type: 1,
                trip_status: 1,
            }
            const list = await BookingService.get_booking_list(filter, projection);
            if (!list) {
                return next(createError.BadRequest("Get list failed"));
            }
            if (list.length === 0) {
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
            if (!update_result) {
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
    async delete_booking(req, res, next) {
        try {
            const booking_id = req.params.id
            // Delete promotion
            const delete_result = await BookingService.delete_booking(booking_id);
            if (!delete_result) {
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