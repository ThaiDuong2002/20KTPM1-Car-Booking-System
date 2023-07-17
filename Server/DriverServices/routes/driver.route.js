import express from 'express';
import DriverController from '../controllers/driver.controller.js';
import Authorization from '../middlewares/authorization.js';

const router = express.Router();

router.get('/me', Authorization.isDriver, DriverController.me);
router.post('/me/edit', Authorization.isDriver, DriverController.edit_info);
router.post('/logout', Authorization.isDriver, DriverController.logout);

export default router;