import bcrypt from 'bcryptjs';
import Admin from '../models/Admin.js';

const TestController = {
  test: (req, res) => {
    res.send('Hello from Driver Services');
  },
  create: async (req, res) => {
    const salt = bcrypt.genSaltSync(10);
    const hash = bcrypt.hashSync(req.body.password, salt);

    const newAdmin = new Admin({
      ...req.body,
      password: hash,
    });
    try {
      const admin = await newAdmin.save();
      res.status(200).json(admin);
    } catch (error) {
      res.status(400).json({ message: error });
    }
  },
};

export default TestController;
