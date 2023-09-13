import createError from "http-errors";
import { BookingService, UserService } from "../services/services.js";

const BookingController = {
  async consultantBooking(req, res, next) {
    try {
      console.log("Consultant: ", req.body);
      await BookingService.sendToBookingReception(req.body);
      res.json({
        message: "The booking is being processed.",
        status: 200,
        data: null,
      });
    } catch (err) {
      next(createError.InternalServerError(err.message));
    }
  },
  async get_history_booking(req, res, next) {
    try {
      const customerPhone = req.params.phone;

      const bookingList = await BookingService.get_history_booking(
        customerPhone
      );
      if (!bookingList) {
        return next(createError.NotFound("Booking not found"));
      }
      res.status(200).json({
        message: "Get history booking successfully",
        status: 200,
        data: bookingList,
      });
    } catch (error) {
      next(createError.InternalServerError(error.message));
    }
  },
  async add_booking(req, res, next) {
    try {
      const bookingInfo = req.body;
      // Validate driver
      const driver = await UserService.get_user_by_id(bookingInfo.driverId);
      if (!driver || driver.userRole !== "driver") {
        return next(createError.BadRequest("Driver not exist"));
      }
      if (!driver.isActive) {
        return next(createError.BadRequest("Driver is not active"));
      }

      const userInfo = {
        id: req.headers["x-user-id"],
        role: req.headers["x-user-role"],
      };
      bookingInfo.userId = userInfo.id;
      // Create booking
      const newBooking = await BookingService.create_booking(bookingInfo);
      res.status(201).json({
        message: "Create booking successfully",
        status: 201,
        data: newBooking,
      });
    } catch (err) {
      next(createError.InternalServerError(err.message));
    }
  },
  async get_booking_details(req, res, next) {
    try {
      const booking_id = req.params.id;
      const populateOptions = {
        userId: "-password -refreshToken",
        driverId: "-password -refreshToken",
        promotionId: "",
        paymentMethodId: "",
        refundId: "",
      };
      const booking = await BookingService.get_booking_details(
        booking_id,
        populateOptions
      );
      if (!booking) {
        return next(createError.NotFound("Booking not found"));
      }
      res.status(200).json({
        message: "Get booking details successfully",
        status: 200,
        data: booking,
      });
    } catch (err) {
      next(createError.InternalServerError(err.message));
    }
  },
  async get_booking_list(req, res, next) {
    try {
      let filter = req.body;
      let projection = {
        createdAt: 1,
        customerName: 1,
        customerPhone: 1,
        pickupLocation: 1,
        destinationLocation: 1,
        type: 1,
        status: 1,
      };
      const list = await BookingService.get_booking_list(filter, projection);
      if (!list) {
        return next(createError.BadRequest("Get list failed"));
      }
      if (list.length === 0) {
        return next(createError.NotFound("No booking found"));
      }
      res.status(200).json({
        message: "Get bookings list successfully",
        status: 200,
        data: list,
      });
    } catch (err) {
      next(createError.InternalServerError(err.message));
    }
  },
  async update_booking(req, res, next) {
    try {
      const booking_id = req.params.id;
      const updateInfo = req.body;
      // Update booking
      const update_result = await BookingService.update_booking(
        booking_id,
        updateInfo
      );
      if (!update_result) {
        return res.status(404).json({
          message: "Booking not found",
          status: 404,
        });
      }
      res.status(200).json({
        message: "Update booking successfully",
        status: 200,
        data: update_result,
      });
    } catch (err) {
      next(createError.InternalServerError(err.message));
    }
  },
  async delete_booking(req, res, next) {
    try {
      const booking_id = req.params.id;
      // Delete promotion
      const delete_result = await BookingService.delete_booking(booking_id);
      if (!delete_result) {
        return res.status(404).json({
          message: "Booking not found",
          status: 404,
        });
      }
      res.status(200).json({
        message: "Delete promotion successfully",
        status: 200,
        data: delete_result,
      });
    } catch (err) {
      next(createError.InternalServerError(err.message));
    }
  },
  async get_most_location(req, res, next) {
    try {
      const phone = req.params.phone;
      const result = await BookingService.get_most_location(phone);
      if (!result) {
        return res.status(404).json({
          message: "Booking not found",
          status: 404,
        });
      }
      res.status(200).json({
        message: "Get most location successfully",
        status: 200,
        data: result,
      });
    } catch (err) {
      next(createError.InternalServerError(err.message));
    }
  },
};

export default BookingController;
