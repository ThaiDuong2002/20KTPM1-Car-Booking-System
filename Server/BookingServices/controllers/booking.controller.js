import createError from 'http-errors';
import { create_booking_schema, update_booking_schema } from '../middlewares/validate.js';
import { BookingService, UserService } from '../services/database_services.js';

const BookingController = {
    async get_bookings_list(req, res, next) {
        let filter = req.body
        const list = await BookingService.get_bookings_list(filter);
        res.json({
            message: 'Get bookings list successfully',
            status: 200,
            data: list,
        })
    },
    async get_booking_details(req, res, next) {
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
    },
    async create_booking(req, res, next) {
        const { error, value } = create_booking_schema.validate(req.body);
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
        booking_data.user_id = user_id
        // Create booking
        try {
            const booking_re = await BookingService.create_booking(booking_data);
            res.status(201).json({
                message: 'Create booking successfully',
                status: 201,
                data: booking_re,
            })
        } catch (err) {
            return next(createError.BadRequest(err.message));
        }
    },
    async update_booking(req, res, next) {
        const booking_id = req.params.id
        const { error, value } = update_booking_schema.validate(req.body);
        if (error) {
            return next(createError.BadRequest(error.details[0].message));
        }
        let update_fields = value
        // Update booking
        const update_result = await BookingService.update_booking(booking_id, update_fields);
        res.status(200).json({
            message: 'Update booking successfully',
            status: 200,
            data: update_result,
        })
    },
}

export default BookingController;