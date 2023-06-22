import jwt from "jsonwebtoken";
import createError from "http-errors";
import dotenv from 'dotenv';
dotenv.config();
const TokenService = {
    async verifyToken(req, res, next) {
        console.log("Verify token");
        if (!req.headers['authorization']) {

            next(createError.Unauthorized("You are not authorized to access this page.1"));
        } else {
            const authorization = req.headers['authorization'];
            const bearToken = authorization.split(' ');
            const token = bearToken[1];
            console.log(token);
            jwt.verify(token, "KEY", (err, payload) => {
                if (err) {
                    if (err.name === "JsonWebTokenError") {
                        return next(createError.Unauthorized("You are not authorized to access this page"));
                    }
                    return next(createError.Unauthorized(err.message));
                }
                req.payload = payload;
                req.headers['x-user-role'] = req.payload.userType;
                next();

            });

        }
    },

}

export default TokenService;