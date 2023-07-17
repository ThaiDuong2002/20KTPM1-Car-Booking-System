import express from 'express';
import CustomerController from '../controllers/customer.controller.js';
import Authorization from '../middlewares/authorization.js';
const router = express.Router();

router.get('/me', Authorization.isCustomer, CustomerController.me)
router.post('/me/edit', Authorization.isCustomer, CustomerController.edit_info)
router.post('/logout', Authorization.isCustomer, CustomerController.logout)


export default router;