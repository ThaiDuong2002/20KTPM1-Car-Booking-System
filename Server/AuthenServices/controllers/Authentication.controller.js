import createError from 'http-errors';
import { User, Consultant, Driver, Customer } from '../models/User.model.js';
import TokenService from '../middlewares/jwt_services.js';
import bcryptjs from 'bcryptjs';
import registration_schema from '../middlewares/validate.js'
import dotenv from 'dotenv';

const AuthenController = {
    async login(req, res, next) {
        try {
            const { identifier, password } = req.body;
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
                const checkAuthen = bcryptjs.compareSync(password, user.password); // true
                if (!checkAuthen) {
                    next(createError.BadRequest("Wrong password"))
                }
                else {
                    const access_token = await TokenService.signAccessToken(user._id, user.__t)
                    const refresh_token = await TokenService.signRefreshToken(user._id, "30d")
                    const updatedUser = await User.findOneAndUpdate(
                        { _id: user._id },
                        { refreshToken: refresh_token },
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
                            accessToken: access_token,
                            refreshToken: refresh_token,
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
    async register(req, res, next) {
        try {
            // Validate registration form
            const { error, value } = registration_schema.validate(req.body)

            if (error) {
                next(createError.BadRequest(error.details[0].message))
            }

            const user_role = req.params.role
            if (user_role !== "consultant" && user_role !== "driver" && user_role !== "customer") {
                next(createError.BadRequest("Invalid role"))
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
            const salt = bcryptjs.genSaltSync(10)
            const hash = bcryptjs.hashSync(password, salt)

            let newUser;

            // Create new user based on role
            switch (user_role) {
                case "consultant":
                    newUser = new Consultant({
                        firstname,
                        lastname,
                        email,
                        phone,
                        password: hash,
                    });
                    break;
                case "driver":
                    newUser = new Driver({
                        firstname,
                        lastname,
                        email,
                        phone,
                        password: hash,
                    });
                    break;
                case "customer":
                    newUser = new Customer({
                        firstname,
                        lastname,
                        email,
                        phone,
                        password: hash,
                    });
                    break;
                default:
                    next(createError.BadRequest("Invalid role"))
            }

            // Save new user to the database
            const result = await newUser.save();

            if (!result) {
                throw createError.BadRequest("Failed to save new user to the database");
            }

            // Send response
            const response = {
                user: {
                    id: newUser._id,
                    __t: newUser.__t,
                    firstname: newUser.firstname,
                    lastname: newUser.lastname,
                    email: newUser.email,
                    phone: newUser.phone,
                    avatar: newUser.avatar
                }
            };

            // Save new User to req.user
            req.user = newUser

            // Response
            res.status(200).json({
                message: "Register successfully",
                status: 200,
                data: response
            })
        } catch (error) {
            next(createError.BadRequest(error.message))
        }
    },
    async renewAccessToken(req, res, next) {
        const { refreshToken } = req.body;
        if (!refreshToken) {
            next(createError.BadRequest("Need to provide refresh token"))
        }
        try {
            // Verify refresh token
            const decoded = await TokenService.verifyRefreshToken(refreshToken)
            console.log("decoded.exp", decoded.exp)

            // // Check if the refresh token is associated with a valid user
            // const user = await User.findOne({ _id: decoded.user_id })
            // if (!user) {
            //     next(createError.BadRequest("Invalid refresh token"))
            // }

            // // Issue new access token and refresh token
            // const refreshTokenExpiration = decoded.exp - Math.floor(Date.now() / 1000)
            // const access_token = await TokenService.signAccessToken(user._id, user.__t)
            // const refresh_token = await TokenService.signRefreshToken(user._id, refreshTokenExpiration)

            // // Save refresh token to db
            // const updatedUser = await User.findOneAndUpdate(
            //     { _id: user._id },
            //     { refreshToken: refresh_token },
            //     { new: true }
            // );
            // if (!updatedUser) {
            //     next(createError.BadRequest("Failed to save refresh token to database"))
            // }

            // // Return access token
            // res.json({
            //     message: "Renew access token successfully",
            //     status: 201,
            //     data: {
            //         token: access_token
            //     }
            // })

        } catch (err) {
            if (err.name === "TokenExpiredError") {
                return next(createError.Unauthorized("Refresh token expired"));
            }
            return next(createError.Unauthorized(err.message));
        }
    },
}

export default AuthenController;