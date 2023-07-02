import callcenter_registration_schema from '../middlewares/validate.js'
import User from '../models/User.js'
import Consultant from '../models/Consultant.js'
import bcrypt from 'bcryptjs';
import TokenService from '../middlewares/jwt_services.js'
import createError from 'http-errors';

const CallcenterController = {
  test: (req, res, next) => {
    res.send('Hello from CallCenter Services')
  },

  register: async (req, res, next) => {
    try {
      // Validate registration form
      const { error, value } = callcenter_registration_schema.validate(req.body)

      if (error) {
        next(createError.BadRequest(error.details[0].message))
      }

      const { firstname, lastname, email, phone, password } = value

      // Check if user is already exists
      const user = await User.findOne({
        $or: [
          { email: email },
          { phone: phone }
        ]
      });

      if (user) {
        next(createError.BadRequest("User is already exists"))
      }

      // Hash password
      const salt = bcrypt.genSaltSync(10)
      const hash = bcrypt.hashSync(password, salt)

      // Create new consultant
      const newConsultant = new Consultant({
        firstname,
        lastname,
        email,
        phone,
        password: hash,
      })
      console.log(newConsultant)

      // Save to db
      const result = await newConsultant.save()
      if (!result) {
        next(createError.BadRequest("Save new consultant to db failed"))
      }

      // Send response
      const response = {
        user: {
          id: newConsultant._id,
          __t: newConsultant.__t,
          firstname: newConsultant.firstname,
          lastname: newConsultant.lastname,
          email: newConsultant.email,
          phone: newConsultant.phone,
          avatar: newConsultant.avatar
        }
      };

      // Save new conslutant to req.user
      req.user = newConsultant

      // Response
      res.status(200).json({
        message: "Register successfully",
        status: 200,
        data: response
      })
    } catch (error) {
      next(error)
    }
  },
};

export default CallcenterController;
