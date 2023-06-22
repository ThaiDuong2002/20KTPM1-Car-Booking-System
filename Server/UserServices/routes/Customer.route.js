import express from 'express';
import CustomerController from '../controllers/Customer.controller.js';
const CustomerRoute = express.Router();
CustomerRoute.get('/customer', CustomerController.testRoute);
CustomerRoute.post('/customer/register', CustomerController.register);
CustomerRoute.post('/customer/refesh-token', CustomerController.refeshToken);

export default CustomerRoute;