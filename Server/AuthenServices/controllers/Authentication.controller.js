import createError from 'http-errors';
import UserService from '../services/database_services.js';
import TokenService from '../middlewares/jwt_services.js';
import bcryptjs from 'bcryptjs';
import validateSchemas from '../middlewares/validate.js';

const { registration_schema, change_password_schema } = validateSchemas;

const AuthenController = {
    async login(req, res, next) {
        try {
            const { identifier, password } = req.body;
            if (!identifier || !password) {
                next(createError.BadRequest("Invalid email or password"))
            }
            else {
                // Lowercase identifier
                let _identifier = identifier.toLowerCase()
                const user = await UserService.getUserByIdentifier(_identifier, _identifier)
                if (!user) {
                    next(createError.BadRequest("User is not exists"))
                }
                const checkAuthen = bcryptjs.compareSync(password, user.password)
                if (!checkAuthen) {
                    next(createError.BadRequest("Wrong password"))
                }
                else {
                    const access_token = await TokenService.signAccessToken(user._id, user.__t)
                    const refresh_token = await TokenService.signRefreshToken(user._id, "30d")
                    const updatedUser = await UserService.updateUser(user._id, { refreshToken: refresh_token })
                    if (!updatedUser) {
                        next(createError.BadRequest("Update user's info failed"))
                    }
                    const response = {
                        user: {
                            id: updatedUser._id,
                            role: updatedUser.role,
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
                    res.json({
                        message: "Login successfully",
                        status: 200,
                        data: response
                    })
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

            // Check if user is already exists
            const user = await UserService.getUserByIdentifier(value.email, value.phone)
            if (user) {
                next(createError.BadRequest("User is already exists"))
            }

            // Create new user
            const newUser = await UserService.createUser(user_role, value)

            // Send response
            const response = {
                user: {
                    id: newUser._id,
                    role: newUser.role,
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
            next(error.message)
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

            // Check if the refresh token is associated with a valid user
            const auth_user = await UserService.getUserById(decoded.userId, { refreshToken: refreshToken })

            if (!auth_user) {
                next(createError.BadRequest("Invalid refresh token"))
            }

            // Issue new access token and refresh token
            const refreshTokenExpiration = decoded.exp - Math.floor(Date.now() / 1000)
            const access_token = await TokenService.signAccessToken(auth_user._id, auth_user.__t)
            const refresh_token = await TokenService.signRefreshToken(auth_user._id, refreshTokenExpiration)

            // Save new refresh token to database
            const updatedUser = await UserService.updateUser(auth_user._id, { refreshToken: refresh_token })
            if (!updatedUser) {
                next(createError.BadRequest("Failed to save refresh token to database"))
            }

            // Return access token
            res.json({
                message: "Renew access token successfully",
                status: 201,
                data: {
                    accessToken: access_token,
                    refreshToken: refresh_token
                }
            })

        } catch (err) {
            if (err.name === "TokenExpiredError") {
                return next(createError.Unauthorized("Refresh token expired"));
            }
            return next(createError.Unauthorized(err.message));
        }
    },
    async change_password(req, res, next) {
        const { error, value } = change_password_schema.validate(req.body)
        if (error) {
            return next(createError.BadRequest(error.details[0].message))
        }
        const user_id = req.payload.userId
        let user = await UserService.getUserById(user_id)
        if(!user) {
            return next(createError.NotFound("User is not exists"))
        }
        const check_password = bcryptjs.compareSync(value.old_password, user.password)
        if(!check_password) {
            return next(createError.BadRequest("Wrong password"))
        }
        const salt = bcryptjs.genSaltSync(10)
        const hash_password = bcryptjs.hashSync(value.new_password, salt)

        try {
            await UserService.updateUser(user_id, {password: hash_password})
        } catch (error) {
            return next(createError.BadRequest(error.message))
        }

        res.status(200).json({
            message: "Change password successfully",
            status: 200,
            data: "ok"
        })
    }
}

export default AuthenController;