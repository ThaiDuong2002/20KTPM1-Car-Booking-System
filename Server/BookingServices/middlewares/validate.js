import Joi from 'joi';

const create_booking_schema = Joi.object({
    driver_id: Joi.string().required(),
    pickup_location: Joi.object({
        address: Joi.string().required(),
        coordinate: Joi.object({
            x: Joi.number().required(),
            y: Joi.number().required(),
        }).required()
    }),
    destination_location: Joi.object({
        address: Joi.string().required(),
        coordinate: Joi.object({
            x: Joi.number().required(),
            y: Joi.number().required(),
        }).required()
    }),
    fare: Joi.number().required(),
    promotion_id: Joi.string(),
    payment_method_id: Joi.string(),
    pickup_time: Joi.date().required(),
    dropoff_time: Joi.date(),
    refund_id: Joi.number(),
    rating: Joi.object({
        comment: Joi.string().allow(''),
        score: Joi.number().integer().min(1).max(10)
    }).required(),
});

const update_booking_schema = Joi.object({
    status: Joi.string().valid('Pending', 'Confirm', 'In-progress', 'Completed', 'Cancel', 'Pre-book'),
    dropoff_time: Joi.date(),
    refund_id: Joi.number(),
    rating: Joi.object({
        comment: Joi.string().allow(''),
        score: Joi.number().integer().min(1).max(10)
    })
});

export {
    create_booking_schema,
    update_booking_schema
}