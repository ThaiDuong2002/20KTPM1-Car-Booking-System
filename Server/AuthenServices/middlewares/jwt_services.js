import jwt from "jsonwebtoken";
import createError from "http-errors";
import dotenv from 'dotenv';
dotenv.config();

const secret = process.env.ACCESS_TOKEN_SECRET;

const TokenService = {
    async signAccessToken(userId, userType) {
        return new Promise((resolve, reject) => {
            const payload = { userId, userType };
            const options = {
                expiresIn: "10m",
            };
            jwt.sign(payload, secret, options, (err, token) => {
                if (err) {
                    reject(err);
                }
                resolve(token);
            });
        });
    },
    async verifyAccessToken(req, res, next) {
        if (!req.headers['authorization']) {

            next(createError.Unauthorized("You are not authorized to access this page"));
        } else {
            const authorization = req.headers['authorization'];
            const bearToken = authorization.split(' ');
            const token = bearToken[1];
            console.log(token);
            jwt.verify(token, secret, (err, payload) => {
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
    async signRefreshToken(userId, refreshTokenExpiration) {
        return new Promise((resolve, reject) => {
            const payload = { userId };
            const options = {
                expiresIn: refreshTokenExpiration,
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
            jwt.verify(refreshToken, secret, (err, decoded) => {
                if (err) {
                    reject(err)
                }
                resolve(decoded)
            })
        });
    }
}

export default TokenService;