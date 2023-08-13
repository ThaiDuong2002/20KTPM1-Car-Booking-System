import bcrypt from 'bcryptjs';


const TestController = {
  test: (req, res) => {
    res.send('Hello from Driver Services');
  },
  create: async (req, res) => {
    const salt = bcrypt.genSaltSync(10);
    const hash = bcrypt.hashSync(req.body.password, salt);

    const newCustomer = new Customer({
      ...req.body,
      password: hash,
    });
    try {
      const customer = await newCustomer.save();
      res.status(200).json(customer);
    } catch (error) {
      res.status(400).json({ message: error });
    }
  },
};

export default TestController;
