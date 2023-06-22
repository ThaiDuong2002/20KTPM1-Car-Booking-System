import createError from 'http-errors';
import { Customer } from '../models/User.model.js';
import TokenService from '../middlewares/jwt_services.js';
import bcrypt from "bcrypt";
const CustomerController = {
    async testRoute(req, res, next) {
        res.send("Hello from Consultant route")
    },
    async register(req, res, next) {
        try {
            const { firstname, lastname, phone, email, password } = req.body
            if (!email || !password) {
                next(createError.BadRequest("Invalid email or password"))
            }
            const isExistEmail = await Customer.findOne({
                email: email
            });
            const isExistPhone = await Customer.findOne({
                phone: phone
            });
            if (isExistEmail) {
                next(createError.Conflict(`${email} is already been registered`))
            }
            if (isExistPhone) {
                next(createError.Conflict(`${phone} is already in use.`))
            }
            else {
                const salt = bcrypt.genSaltSync(10);
                const hash = bcrypt.hashSync(password, salt);
                const newCustomer = await Customer.create({
                    firstname: firstname,
                    lastname: lastname,
                    phone: phone,
                    email: email,
                    password: hash
                })
                await newCustomer.save();

                return res.status(200).json({
                    message: "Register successfully",
                    status: 200,
                    data: newCustomer
                })
            }
        } catch (error) {
            next(error);
        }

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

export default CustomerController;