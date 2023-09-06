import express from 'express';
import DriverController from '../controllers/driverController.js';
import {authorization} from '../middlewares/authorization.js';

const router = express.Router();

router.get('/me', authorization(['driver']), DriverController.me);
router.get('/me/vehicle', authorization(['driver']), DriverController.get_my_vehicle);
router.post('/me/edit', authorization(['driver']), DriverController.edit_info);
router.post('/logout', authorization(['driver']), DriverController.logout);

router.get('/driver_locations', DriverController.get_driver_locations);
router.post('/update_location', authorization(['driver']), DriverController.update_location);

export default router;