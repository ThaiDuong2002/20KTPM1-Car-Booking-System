import Joi from 'joi';

const create_promotion_schema = Joi.object({
    name: Joi.string().required(),
    strategy: Joi.string().required(),
    description: Joi.string().required(),
    discount: Joi.number().min(0).required(),
    startDate: Joi.date().required(),
    endDate: Joi.date().required(),
    usage_limit: Joi.number().integer().min(0).required()
});

const update_promotion_schema = Joi.object({
    name: Joi.string(),
    strategy: Joi.string(),
    description: Joi.string(),
    discount: Joi.number().min(0),
    startDate: Joi.date(),
    endDate: Joi.date(),
    usage_limit: Joi.number().integer().min(0)
});

export {
    create_promotion_schema,
    update_promotion_schema
}