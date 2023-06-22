import express from 'express';
import UserController from '../controllers/User.controller.js';
const UserRoute = express.Router();
UserRoute.get('/', UserController.testRoute);
UserRoute.post('/login', UserController.login);
UserRoute.post('/logout', UserController.logout);
export default UserRoute;