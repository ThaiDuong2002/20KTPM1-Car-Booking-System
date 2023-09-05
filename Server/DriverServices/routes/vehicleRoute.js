import express from 'express';
import VehicleController from '../controllers/vehicleController.js';

const router = express.Router();

router.get('/vehicle/list', VehicleController.get_vehicle_type_list);

export default router;