import express from 'express';
import DriverController from '../controllers/driver.controller.js';
import {authorization} from '../middlewares/authorization.js';

const router = express.Router();

router.get('/me', authorization(['driver']), DriverController.me);
router.post('/me/edit', authorization(['driver']), DriverController.edit_info);
router.post('/logout', authorization(['driver']), DriverController.logout);

export default router;