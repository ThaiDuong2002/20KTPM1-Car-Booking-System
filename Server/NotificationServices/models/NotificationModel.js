import mongoose from "mongoose";

const Schema = mongoose.Schema;

const NotificationModel = new Schema(
  {
    title: {
      type: String,
      required: true,
    },
    content: {
      type: String,
      required: true,
    },
    userId: {
      type: Schema.Types.ObjectId,
      required: true,
      ref: "User",
    },
    deviceId: {
      type: String,
      required: true,
    },
    isRead: {
      type: Boolean,
      default: false,
    },
    type: {
      type: String,
      default: "system",
      enum: ["system", "booking", "promotion"],
    },
  },
  {
    timestamps: true,
  }
);

export default mongoose.model(
  "Notification",
  NotificationModel,
  "notifications"
);
