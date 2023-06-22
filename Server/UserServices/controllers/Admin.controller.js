import createError from 'http-errors';
import { Admin } from '../models/User.model.js';
import TokenService from '../middlewares/jwt_services.js';
const AdminController = {
    async testRoute(req, res, next) {

        res.send("Hello from Admin route")
    },
    async refeshToken(req, res, next) {
        try {
            const { refeshToken } = req.body;
            console.log(req.body);
            if (!refeshToken) return next(createError.BadRequest())
            else {
                const { userId } = await TokenService.verifyRefreshToken(refeshToken);
                console.log(userId);
                const accestoken = await TokenService.signAccessToken(userId);
                const refToken = await TokenService.signRefreshToken(userId);
                res.json({
                    token: accestoken,
                    refeshToken: refToken
                });
            }

        } catch (error) {
            next(error)
        }

    },
}

export default AdminController;