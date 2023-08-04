import express from 'express';
import CustomerController from '../controllers/customer.controller.js';
import {authorization} from '../middlewares/authorization.js';

const router = express.Router();

router.get('/me', authorization(['customer']), CustomerController.me)
router.post('/me/edit', authorization(['customer']), CustomerController.edit_info)
router.post('/logout', authorization(['customer']), CustomerController.logout)
router.put('/upgrade', authorization(['customer']), CustomerController.upgrade)

export default router;