import Joi from 'joi';

const registration_schema = Joi.object({
  firstname: Joi.string().required(),
  lastname: Joi.string().required(),
  email: Joi.string().email().required(),
  phone: Joi.string().pattern(/^[0-9]+$/).required(),
  password: Joi.string()
    .min(6)
    .max(20)
    .regex(/^[a-zA-Z0-9!@#$%^&*]{6,20}$/)
    .required(),
});

export default registration_schema;