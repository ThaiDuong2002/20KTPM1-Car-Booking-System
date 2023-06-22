import express from 'express';
import DriverController from '../controllers/Driver.controller.js';
const DriverRoute = express.Router();
DriverRoute.get('/driver', DriverController.testRoute);
DriverRoute.post('/driver/register', DriverController.register);
DriverRoute.post('/driver/refesh-token', DriverController.refeshToken);
export default DriverRoute;