import express from 'express';
import AuthenticationController from '../controllers/Authentication.controller.js';
const AuthenRoute = express.Router();
AuthenRoute.post('/login', AuthenticationController.login);
AuthenRoute.post('/register/:role', AuthenticationController.register);
AuthenRoute.post('/renewAccessToken', AuthenticationController.renewAccessToken);

export default AuthenRoute;
