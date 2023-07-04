import createError from 'http-errors';
import { User, Consultant } from '../models/User.model.js';
import TokenService from '../middlewares/jwt_services.js';
// import bcrypt from "bcrypt";
import bcrypt from 'bcryptjs';
import conslutant_registration_schema from '../middlewares/validate.js'

const AuthenController = {
    async testRoute(req, res, next) {
        res.send("Hello from User route")
    },
    async login(req, res, next) {
        try {
            const { identifier, password } = req.body;
            console.log(req.body);
            if (!identifier || !password) {
                next(createError.BadRequest("Invalid email or password"))
            }
            else {
                const user = await User.findOne({
                    $or: [
                        { email: identifier },
                        { phone: identifier }
                    ]
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
    async consultant_register(req, res, next) {
        try {
            // Validate registration form
            const { error, value } = conslutant_registration_schema.validate(req.body)

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
}

export default AuthenController;