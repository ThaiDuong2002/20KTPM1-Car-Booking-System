import express from 'express';
import AuthenticationController from '../controllers/Authentication.controller.js';
import TokenService from '../middlewares/jwt_services.js';

const AuthenRoute = express.Router();

AuthenRoute.post('/login', AuthenticationController.login);
AuthenRoute.post('/register/:role', AuthenticationController.register);
AuthenRoute.post('/renewAccessToken', AuthenticationController.renewAccessToken);
AuthenRoute.put('/changePassword', TokenService.verifyAccessToken, AuthenticationController.change_password);

export default AuthenRoute;
