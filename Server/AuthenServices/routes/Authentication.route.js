import express from 'express';
import AuthenticationController from '../controllers/Authentication.controller.js';
const AuthenRoute = express.Router();
AuthenRoute.get('/', AuthenticationController.testRoute);
AuthenRoute.post('/login', AuthenticationController.login);
AuthenRoute.post('/logout', AuthenticationController.logout);
export default AuthenRoute;
