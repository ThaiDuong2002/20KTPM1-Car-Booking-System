import Joi from 'joi';

const create_notification_schema = Joi.object({
    title: Joi.string().required(),
    content: Joi.string().required(),
    time: Joi.date().iso().required(),
    user_id: Joi.string().required(),
    device_id: Joi.string().required(),
    type: Joi.string().required()
});

const update_notification_schema = Joi.object({
    title: Joi.string(),
    content: Joi.string(),
    time: Joi.date().iso(),
    user_id: Joi.string(),
    device_id: Joi.string(),
    type: Joi.string()
});

export {
    create_notification_schema,
    update_notification_schema
}