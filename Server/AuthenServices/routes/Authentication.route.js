import express from 'express';
import AuthenticationController from '../controllers/Authentication.controller.js';
const AuthenRoute = express.Router();
AuthenRoute.post('/login', AuthenticationController.login);
AuthenRoute.post('/consultant/register', AuthenticationController.consultant_register);
export default AuthenRoute;
