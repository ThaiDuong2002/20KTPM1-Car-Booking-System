import Joi from 'joi';

const registrationSchema = Joi.object({
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

const changePasswordSchema = Joi.object({
  old_password: Joi.string()
      .min(6)
      .max(20)
      .regex(/^[a-zA-Z0-9!@#$%^&*]{6,20}$/)
      .required(),
  new_password: Joi.string()
      .min(6)
      .max(20)
      .regex(/^[a-zA-Z0-9!@#$%^&*]{6,20}$/)
      .required(),
});

export default {
    registrationSchema,
    changePasswordSchema
}