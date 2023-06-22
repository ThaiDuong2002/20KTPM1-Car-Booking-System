import express from 'express';
import AdminController from '../controllers/Admin.controller.js';
import Authentication from '../middlewares/authentication.js';
const AdminRoute = express.Router();
AdminRoute.get('/admin', Authentication.isAdmin, AdminController.testRoute);
AdminRoute.post('/refesh-token', AdminController.refeshToken);
export default AdminRoute;