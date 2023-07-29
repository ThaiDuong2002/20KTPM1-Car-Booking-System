import Joi from 'joi';

const create_booking_schema = Joi.object({
    booking_driver_id: Joi.string().required(),
    trip_type: Joi.string().valid('Bike', 'Car').required(),
    trip_pickup_location: Joi.object({
        address: Joi.string().required(),
        coordinate: Joi.object({
            x: Joi.number().required(),
            y: Joi.number().required(),
        }).required()
    }),
    trip_destination_location: Joi.object({
        address: Joi.string().required(),
        coordinate: Joi.object({
            x: Joi.number().required(),
            y: Joi.number().required(),
        }).required()
    }),
    trip_distance: Joi.number().required(),
    trip_duration: Joi.number().required(),
    trip_pre_total: Joi.number().required(),
    trip_total: Joi.number().required(),
    trip_promotion_id: Joi.string(),
    trip_status: Joi.string().valid('Pending', 'Confirm', 'In-progress', 'Completed', 'Cancel', 'Pre-book'),
    trip_pickup_time: Joi.date(),
    trip_dropoff_time: Joi.date(),
    booking_payment_method_id: Joi.string().required(),
    booking_refund_id: Joi.string(),
    booking_ratings: Joi.object({
        user_id: Joi.string(),
        comment: Joi.string().allow(''),
        time: Joi.date().iso(),
        start: Joi.number().integer().min(1).max(5)
    }),
});

const update_booking_schema = Joi.object({
    trip_status: Joi.string().valid('Pending', 'Confirm', 'In-progress', 'Completed', 'Cancel', 'Pre-book'),
    trip_dropoff_time: Joi.date(),
    booking_refund_id: Joi.string(),
    booking_ratings: Joi.object({
        user_id: Joi.string().required(),
        comment: Joi.string().allow(''),
        time: Joi.date().iso(),
        start: Joi.number().integer().min(1).max(5)
    }),
});

export {
    create_booking_schema,
    update_booking_schema
}