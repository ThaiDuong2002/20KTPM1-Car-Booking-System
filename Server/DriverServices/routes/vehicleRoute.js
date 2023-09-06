import express from 'express';
import VehicleController from '../controllers/vehicleController.js';

const router = express.Router();

router.get('/vehicle/list', VehicleController.get_vehicle_type_list);
router.get('/vehicle/:id', VehicleController.get_vehicle_type);
router.post('/vehicle', VehicleController.add_vehicle_type);
router.put('/vehicle/:id', VehicleController.update_vehicle_type);
router.delete('/vehicle/:id', VehicleController.delete_vehicle_type);

export default router;