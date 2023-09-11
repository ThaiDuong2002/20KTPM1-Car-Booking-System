import createError from "http-errors";
import {
    PreBookingService,
} from "../services/services.js";

const PreBookingController = {
    async get_pre_booking_list(req, res, next) {
        try {
            const list = await PreBookingService.getPreBookingList();
            res.status(200).json({
                message: "Get pre booking list successfully",
                status: 200,
                data: list,
            });
        } catch (err) {
            next(createError.InternalServerError(err.message));
        }
    },
    async get_pre_booking_details(req, res, next) {
        try {
            const preBooking_id = req.params.id;
            const result = await PreBookingService.getPreBookingDetails(
                preBooking_id,
                {},
            );
            if (!result) {
                return res.status(404).json({
                    message: "Pre booking not found",
                    status: 404,
                });
            }
            res.status(200).json({
                message: "Get pre booking details successfully",
                status: 200,
                data: result,
            });
        } catch (err) {
            next(createError.InternalServerError(err.message));
        }
    },
    async add_pre_booking(req, res, next) {
        try {
            const preBookingData = req.body;
            const result = await PreBookingService.createPreBooking(
                preBookingData,
            );
            res.status(200).json({
                message: "Add pre booking successfully",
                status: 200,
                data: result,
            });
        } catch (err) {
            next(createError.InternalServerError(err.message));
        }
    },
    async update_pre_booking(req, res, next) {
        try {
            const preBooking_id = req.params.id;
            const updateInfo = req.body;
            // Update pre_booking
            const update_result = await PreBookingService.updatePreBooking(
                preBooking_id,
                updateInfo,
            );
            if (!update_result) {
                return res.status(404).json({
                    message: "Pre booking not found",
                    status: 404,
                });
            }
            res.status(200).json({
                message: "Update pre booking successfully",
                status: 200,
                data: update_result,
            });
        } catch (err) {
            next(createError.InternalServerError(err.message));
        }
    },
    async delete_pre_booking(req, res, next) {
        try {
            const preBooking_id = req.params.id;
            // Delete pre_booking
            const delete_result = await PreBookingService.deletePreBooking(
                preBooking_id,
            );
            if (!delete_result) {
                return res.status(404).json({
                    message: "Pre booking not found",
                    status: 404,
                });
            }
            res.status(200).json({
                message: "Delete pre booking successfully",
                status: 200,
                data: delete_result,
            });
        } catch (err) {
            next(createError.InternalServerError(err.message));
        }
    }
};

export default PreBookingController;
