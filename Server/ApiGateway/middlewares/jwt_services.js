import jwt from "jsonwebtoken";
import createError from "http-errors";
import dotenv from 'dotenv';
dotenv.config();

const secret = process.env.ACCESS_TOKEN_SECRET;

const TokenService = {
    async verifyAccessToken(req, res, next) {
        console.log("secret", secret)
        console.log("Verify token");
        if (!req.headers['authorization']) {
            next(createError.Unauthorized("You are not authorized to access this page"));
        } else {
            const authorization = req.headers['authorization'];
            const bearToken = authorization.split(' ');
            const token = bearToken[1];
            console.log(token);
            jwt.verify(token, secret, { ignoreExpiration: true }, (err, payload) => { // Remember to turn off ignoreExpiration in production
                if (err) {
                    if (err.name === "JsonWebTokenError") {
                        return next(createError.Unauthorized("You are not authorized to access this page"));
                    }
                    return next(createError.Unauthorized(err.message));
                }
                req.payload = payload;
                req.headers['x-user-id'] = req.payload.userId;
                req.headers['x-user-role'] = req.payload.userType;
                console.log("req.headers['x-user-role']", req.headers['x-user-role'])
                next();
            });
        }
    },
}

export default TokenService;