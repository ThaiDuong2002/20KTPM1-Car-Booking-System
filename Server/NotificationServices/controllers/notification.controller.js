import createError from "http-errors";
import { NotificationService, UserService } from "../services/services.js";
import {
  create_notification_schema,
  update_notification_schema,
} from "../middlewares/validate.js";

const NotificationController = {
  async add_notification(req, res, next) {
    try {
      const notificationInfo = req.body;
      console.log("Body: ", notificationInfo);
      // Valid user
      let user = await UserService.getUserById(notificationInfo.userId, {}, {});
      if (!user) {
        return next(createError.NotFound("User not found"));
      }
      // Create notification
      const notification_re = await NotificationService.create_notification(
        notificationInfo
      );
      res.status(201).json({
        message: "Create notification successfully",
        status: 200,
        data: notification_re,
      });
    } catch (err) {
      return next(createError.InternalServerError(err.message));
    }
  },
  async get_notification_details(req, res, next) {
    try {
      const notification_id = req.params.id;
      const notification = await NotificationService.get_notification_details(
        notification_id
      );
      if (!notification) {
        return next(createError.NotFound("Notification not found"));
      }
      res.json({
        message: "Get notification details successfully",
        status: 200,
        data: notification,
      });
    } catch (err) {
      next(createError.InternalServerError(err.message));
    }
  },
  async get_notification_list(req, res, next) {
    try {
      let filter = req.body;
      let projection = {
        // _id: 0,
        title: 1,
        isRead: 1,
        content: 1,
      };
      const list = await NotificationService.get_notification_list(
        filter,
        projection
      );
      if (!list) {
        return next(createError.BadRequest("Get list failed"));
      }
      if (list.length == 0) {
        return next(createError.NotFound("No notification found"));
      }
      res.json({
        message: "Get notifications list successfully",
        status: 200,
        data: list,
      });
    } catch (err) {
      next(createError.InternalServerError(err.message));
    }
  },
  async update_notification(req, res, next) {
    try {
      const notification_id = req.params.id;
      const updateInfo = req.body;
      // Update notification
      const update_result = await NotificationService.update_notification(
        notification_id,
        updateInfo
      );
      if (!update_result) {
        return res.status(404).json({
          message: "Notification not found",
          status: 404,
        });
      }
      res.status(200).json({
        message: "Update notification successfully",
        status: 200,
        data: update_result,
      });
    } catch (err) {
      next(createError.InternalServerError(err.message));
    }
  },
  async delete_notification(req, res, next) {
    try {
      const notification_id = req.params.id;
      // Delete notification
      const delete_result = await NotificationService.delete_notification(
        notification_id
      );
      if (!delete_result) {
        return res.status(404).json({
          message: "Notification not found",
          status: 404,
        });
      }
      res.status(200).json({
        message: "Delete notification successfully",
        status: 200,
        data: delete_result,
      });
    } catch (err) {
      next(createError.InternalServerError(err.message));
    }
  },
};

export default NotificationController;
