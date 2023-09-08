import express from 'express';
import DriverController from '../controllers/driverController.js';
import {authorization} from '../middlewares/authorization.js';

const router = express.Router();

router.get('/me', authorization(['driver']), DriverController.me);
router.get('/me/vehicle/:id', authorization(['driver']), DriverController.get_my_vehicle);
router.put('/me', authorization(['driver']), DriverController.edit_info);
router.post('/logout', authorization(['driver']), DriverController.logout);
router.put('/me/vehicle/:id', authorization(['driver']), DriverController.update_driver_vehicle);

router.get('/driver_locations', DriverController.get_driver_locations);
router.post('/update_location', authorization(['driver']), DriverController.update_location);

export default router;