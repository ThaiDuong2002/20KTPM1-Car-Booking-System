import createError from 'http-errors'
import UserService from '../services/database_services.js';

const CallcenterController = {
  me: async (req, res, next) => {
    try {
      const consultant_id = req.headers['x-user-id']

      const result = await UserService.getUserById(consultant_id, {}, '-_id firstname lastname email phone avatar')

      if (!result) {
        return next(createError.BadRequest("consultant not found"))
      }
      res.json({
        message: "Get consultant's info successfully",
        status: 200,
        data: result
      })
    } catch (error) {
      next(createError.BadRequest(error.message))
    }
  },
  edit_info: async (req, res, next) => {
    try {
      const consultant_id = req.headers['x-user-id']
      const update_info = req.body
      if (update_info.password || update_info.__t || update_info.email || update_info.phone) {
        return next(createError.BadRequest("Invalid update fields"))
      }

      const result = await UserService.updateUser(consultant_id, update_info, '-_id firstname lastname email phone avatar')

      if (!result) {
        return next(createError.BadRequest("consultant not found"))
      }
      res.json({
        message: "Update consultant's info successfully",
        status: 200,
        data: result
      })
    } catch (error) {
      next(createError.BadRequest(error.message))
    }
  },
  logout: async (req, res, next) => {
    try {
      const user_id = req.headers['x-user-id']
      const user = await UserService.getUser({
        _id: user_id,
        refreshToken: ""
      })
      if (user) {
        return next(createError.BadRequest("User already logged out"))
      }
      const updatedUser = await UserService.updateUser(user_id, { refreshToken: '' })
      if (!updatedUser) {
        return next(createError.BadRequest("Update failed"))
      }
      res.json({
        message: "Logout successfully",
        status: 200,
        data: {}
      })
    } catch (error) {
      next(createError.BadRequest(error.message))
    }
  },
};

export default CallcenterController;
