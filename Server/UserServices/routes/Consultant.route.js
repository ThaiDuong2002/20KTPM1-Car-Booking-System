import express from 'express';
import ConsultantController from '../controllers/Customer.controller.js';
const ConsultantRoute = express.Router();
ConsultantRoute.get('/consultant', ConsultantController.testRoute);
ConsultantRoute.post('/consultant/register', ConsultantController.register);
ConsultantRoute.post('/consultant/refesh-token', ConsultantController.refeshToken);

export default ConsultantRoute;