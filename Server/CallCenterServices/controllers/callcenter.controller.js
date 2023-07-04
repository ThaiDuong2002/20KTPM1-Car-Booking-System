import User from '../models/User.js'

const CallcenterController = {
  test: (req, res, next) => {
    res.send('Hello from CallCenter Services')
  },
  me: async (req, res, next) => {
    try {
      const user = req.user;
      console.log("user", user);
      res.json({
        message: "Get user successfully",
        status: 200,
        data: user
      })
    } catch (error) {
      next(error)
    }
  },
  logout: async (req, res, next) => {
    try {
      const user = {
        id: req.headers['x-user-id'],
        role: req.headers['x-user-role']
      }
      console.log("user", user);
      const updatedUser = await User.findOneAndUpdate(
        { _id: user.id },
        { refreshToken: '' },
        { new: true }
      );
      console.log("updatedUser", updatedUser);
      if (updatedUser) {
        res.json({
          message: "Logout successfully",
          status: 200,
          data: {}
        })
      }
    } catch (error) {
      next(error)
    }
  },
};

export default CallcenterController;
