import createError from 'http-errors';
import UserService from '../services/userServices.js';
import TokenService from '../middlewares/jwt_services.js';
import bcryptjs from 'bcryptjs';

const AuthenController = {
    async login(req, res, next) {
        try {
            const {identifier, password} = req.body;
            if (!identifier || !password) {
                return next(createError.BadRequest("Invalid email or password"))
            } else {
                // Lowercase identifier
                let _identifier = identifier.toLowerCase()
                const user = await UserService.getUserByIdentifier(_identifier, _identifier)
                if (!user) {
                    return next(createError.BadRequest("User is not exists"))
                }
                const checkAuthen = bcryptjs.compareSync(password, user.password)
                if (!checkAuthen) {
                    return next(createError.BadRequest("Wrong password"))
                } else {
                    const access_token = await TokenService.signAccessToken(user._id, user.userRole)
                    const refresh_token = await TokenService.signRefreshToken(user._id, "30d")
                    const updatedUser = await UserService.updateUser(user._id, {refreshToken: refresh_token})
                    if (!updatedUser) {
                        return next(createError.BadRequest("Update refresh token failed"))
                    }

                    const response = {
                        _id: updatedUser._id,
                        userRole: updatedUser.userRole,
                        firstname: updatedUser.firstname,
                        lastname: updatedUser.lastname,
                        email: updatedUser.email,
                        phone: updatedUser.phone,
                        dob: updatedUser.dob,
                        gender: updatedUser.gender,
                        avatar: updatedUser.avatar,
                    };

                    res.json({
                        message: "Login successfully",
                        status: 200,
                        data: {
                            user: response,
                            accessToken: access_token,
                            refreshToken: refresh_token,
                        }
                    })
                }
            }
        } catch (error) {
            next(createError.InternalServerError(error.message))
        }
    },
    async register(req, res, next) {
        try {
            // Register info
            const registerInfo = req.body

            // Validate role
            const userRole = req.params.role
            if (userRole !== "consultant" && userRole !== "driver" && userRole !== "customer") {
                return next(createError.BadRequest("Invalid role"))
            }

            // Check if user is already exists
            const user = await UserService.getUserByIdentifier(registerInfo.email, registerInfo.phone)
            if (user) {
                return next(createError.BadRequest("User is already exists"))
            }

            // Create new user
            registerInfo.userRole = userRole
            const newUser = await UserService.createUser(registerInfo)

            // Response
            const response = {
                _id: newUser._id,
                userRole: newUser.userRole,
                firstname: newUser.firstname,
                lastname: newUser.lastname,
                email: newUser.email,
                phone: newUser.phone,
                avatar: newUser.avatar,
            }

            res.status(201).json({
                message: "Register successfully",
                status: 201,
                data: {
                    user: response
                }
            })
        } catch (error) {
            next(createError.InternalServerError(error.message))
        }
    },
    async renewAccessToken(req, res, next) {
        const {refreshToken} = req.body;
        if (!refreshToken) {
            return next(createError.BadRequest("Need to provide refresh token"))
        }
        try {
            // Verify refresh token
            const decoded = await TokenService.verifyRefreshToken(refreshToken)

            // Check if the refresh token is associated with a valid user
            const auth_user = await UserService.getUserById(decoded.userId, {refreshToken: refreshToken})

            if (!auth_user) {
                return next(createError.BadRequest("Invalid refresh token"))
            }

            // Issue new access token and refresh token
            const refreshTokenExpiration = decoded.exp - Math.floor(Date.now() / 1000)
            const new_access_token = await TokenService.signAccessToken(auth_user._id, auth_user.userRole)
            const new_refresh_token = await TokenService.signRefreshToken(auth_user._id, refreshTokenExpiration)

            // Save new refresh token to database
            const updatedUser = await UserService.updateUser(auth_user._id, {refreshToken: new_refresh_token})
            if (!updatedUser) {
                return next(createError.BadRequest("Failed to save refresh token to database"))
            }

            // Return access token
            res.json({
                message: "Renew access token successfully",
                status: 201,
                data: {
                    accessToken: new_access_token,
                    refreshToken: new_refresh_token
                }
            })

        } catch (err) {
            if (err.name === "TokenExpiredError") {
                next(createError.Unauthorized("Refresh token expired"));
            }
            next(createError.Unauthorized(err.message));
        }
    },
    async change_password(req, res, next) {
        try {
            const changePasswordInfo = req.body
            const user_id = req.payload.userId
            let user = await UserService.getUserById(user_id)
            if (!user) {
                return next(createError.NotFound("User is not exists"))
            }
            const check_password = bcryptjs.compareSync(changePasswordInfo.old_password, user.password)
            if (!check_password) {
                return next(createError.BadRequest("Wrong password"))
            }
            const salt = bcryptjs.genSaltSync(10)
            const hash_password = bcryptjs.hashSync(changePasswordInfo.new_password, salt)

            await UserService.updateUser(user_id, {password: hash_password})

            res.status(200).json({
                message: "Change password successfully",
                status: 200,
                data: "ok"
            })
        } catch (error) {
            next(createError.InternalServerError(error.message))
        }
    },
}

export default AuthenController;