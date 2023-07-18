import express from 'express';
import BookingController from '../controllers/booking.controller.js';
const router = express.Router();

// router.get('/', BookingController.get_bookings_list);
router.post('/', BookingController.create_booking);
// router.put('/:id', BookingController.update_booking);

export default router;
