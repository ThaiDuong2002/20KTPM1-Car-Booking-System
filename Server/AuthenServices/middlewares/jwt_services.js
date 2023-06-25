import jwt from "jsonwebtoken";
import createError from "http-errors";
import dotenv from 'dotenv';
dotenv.config();
const TokenService = {
    async signAccessToken(userId, userType) {
        return new Promise((resolve, reject) => {
            const payload = { userId, userType };
            // const secret = process.env.ACCESS_TOKEN_SECRET;
            const secret = "KEY"
            const options = {
                expiresIn: "60s",
            };
            jwt.sign(payload, secret, options, (err, token) => {
                if (err) {
                    reject(err);
                }
                resolve(token);
            });
        });
    },
    async verifyToken(req, res, next) {
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
                next();
            });

        }
    },
    async signRefreshToken(userId) {
        return new Promise((resolve, reject) => {
            const payload = { userId };
            // const secret = process.env.ACCESS_TOKEN_SECRET;
            const secret = "KEY"
            const options = {
                expiresIn: "1y",
            };
            jwt.sign(payload, secret, options, (err, token) => {
                if (err) {
                    reject(err);
                }
                resolve(token);
            });
        });
    },
    async verifyRefreshToken(refreshToken) {
        return new Promise((resolve, reject) => {
            jwt.verify(refreshToken, "KEY", (err, payload) => {
                if (err) {
                    return reject(err)
                }
                resolve(payload)
            })
        });
    }

}

export default TokenService;