import express from "express";
import BookingController from "../controllers/booking.controller.js";
import { authorization } from "../middlewares/authorization.js";

const router = express.Router();

router.get("/", BookingController.get_booking_list);
router.get("/:id", BookingController.get_booking_details);
router.get("/history/:phone", BookingController.get_history_booking);
router.get("/most_location/:phone", BookingController.get_most_location);
router.post("/", authorization(["consultant", "customer"]), BookingController.add_booking);
router.put("/:id", BookingController.update_booking);
router.delete("/:id", BookingController.delete_booking);
router.post("/consultant", BookingController.consultantBooking);
router.get("/driver/:id", BookingController.get_booking_list_by_driver);
router.get("/user/:id/" , BookingController.get_booking_list_by_user);

export default router;
