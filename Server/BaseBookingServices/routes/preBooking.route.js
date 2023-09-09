import express from "express";
import PreBookingController from "../controllers/preBooking.controller.js";

const router = express.Router();

router.get("/", PreBookingController.get_pre_booking_list);
router.get("/:id", PreBookingController.get_pre_booking_details);

router.post("/", PreBookingController.add_pre_booking);

router.put("/:id", PreBookingController.update_pre_booking);

router.delete("/:id", PreBookingController.delete_pre_booking);

export default router;
