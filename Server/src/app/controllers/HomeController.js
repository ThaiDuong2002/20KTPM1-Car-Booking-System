import User from '../models/User.js';

const HomeController = {
  index: (req, res) => {
    User.find({}, (err, users) => {
      if (err) {
        res.json({
          status: 'failed',
          message: err,
        });
      } else {
        res.json({
          status: 'success',
          message: 'Users retrieved successfully',
          data: users,
        });
      }
    });
  },
};

export default HomeController;
