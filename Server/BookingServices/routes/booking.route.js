import express from 'express';
import BookingController from '../controllers/booking.controller.js';
const router = express.Router();

router.get('/', BookingController.get_booking_list);
router.get('/:id', BookingController.get_booking_details);
router.post('/', BookingController.add_booking);
router.put('/:id', BookingController.update_booking);
router.delete('/:id', BookingController.delete_booking);


export default router;