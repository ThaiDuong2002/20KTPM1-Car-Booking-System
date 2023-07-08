import User from '../models/User.js'
import Consultant from '../models/Consultant.js'

const CallcenterController = {
  me: async (req, res, next) => {
    try {
      const consultant_id = req.headers['x-user-id']

      const result = await User.findOne({ _id: consultant_id }).select('-_id firstname lastname email phone avatar');
      if (!result) {
        res.json({
          message: "consultant not found",
          status: 404,
          data: {}
        })
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
      const result = await User.findOneAndUpdate(
        { _id: consultant_id },
        update_info,
        { new: true }
      ).select('-_id firstname lastname email phone avatar')
      console.log("Update result", result)
      if (!result) {
        res.json({
          message: "consultant not found",
          status: 404,
          data: {}
        })
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
      const updatedUser = await User.findOneAndUpdate(
        { _id: user_id },
        { refreshToken: '' },
        { new: true }
      );
      if (updatedUser) {
        res.json({
          message: "Logout successfully",
          status: 200,
          data: {}
        })
      }
    } catch (error) {
      next(createError.BadRequest(error.message))
    }
  },
};

export default CallcenterController;
