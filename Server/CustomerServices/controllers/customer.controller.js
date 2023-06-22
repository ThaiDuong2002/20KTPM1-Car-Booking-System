const CustomerController = {
  test: (req, res) => {
    res.send('Hello from Customer Services');
  },
  async login(req, res, next) {
    try {
      const { email, password } = req.body;

      if (!email || !password) {
        next(createError.BadRequest("Invalid email or password"))
      }
      else {
        const user = await User.findOne({
          email: email
        });
        if (!user) {
          next(createError.BadRequest("User is not exist"))
        }
        const salt = bcrypt.genSaltSync(10);
        const checkAuthen = bcrypt.compareSync(password, user.password); // true
        if (!checkAuthen) {
          next(createError.BadRequest("Wrong password"))
        }
        else {
          const access_Token = await TokenService.signAccessToken(user._id, user.__t)
          const refesh_Token = await TokenService.signRefreshToken(user._id)
          const updatedUser = await User.findOneAndUpdate(
            { _id: user._id },
            { refeshToken: refesh_Token },
            { new: true }
          );
          if (updatedUser) {
            const response = {
              user: {
                id: updatedUser._id,
                __t: updatedUser.__t,
                address: updatedUser.address,
                firstname: updatedUser.firstname,
                lastname: updatedUser.lastname,
                email: updatedUser.email,
                phone: updatedUser.phone,
                avatar: updatedUser.avatar
              },
              token: access_Token,
            };
            req.user = updatedUser
            if (checkAuthen) {
              res.json({
                message: "Login successfully",
                status: 200,
                data: response
              })
            }
          }
        }
      }
    } catch (error) {
      next(error)
    }
  },
  async logout(req, res, next) {
    try {
      const { user } = req.body;
      const updatedUser = await User.findOneAndUpdate(
        { _id: user.id },
        { refeshToken: '' },
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
      next(error)
    }
  },
};

export default CustomerController;
