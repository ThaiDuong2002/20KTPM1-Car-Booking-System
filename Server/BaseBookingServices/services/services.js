import { Booking, PreBooking } from "../models/BookingModel.js";
import { User } from "../models/UserModel.js";
import { Vehicle } from "../models/VehicleModel.js";
import { Promotion } from "../models/PromotionModel.js";
import { PaymentMethod } from "../models/PaymentMethodModel.js";
import { Refund } from "../models/RefundModel.js";

import axios from "axios";
import amqp from "amqplib";
import dotenv from "dotenv";

dotenv.config();

const config = process.env;

const PreBookingService = {
  async getPreBookingList(filter, projection) {
    return PreBooking.find(filter).select(projection).sort({ createdAt: -1 });
  },
  async getPreBookingDetails(preBookingId, populate_options) {
    const query = PreBooking.findById(preBookingId);
    if (populate_options) {
      for (const field in populate_options) {
        // For other fields, apply the provided select options
        query.populate({
          path: field,
          select: populate_options[field],
        });
      }
    }
    return await query.exec();
  },
  async createPreBooking(preBookingData) {
    try {
      const preBooking = new PreBooking(preBookingData);
      await preBooking.save();
      await axios.post("http://socket-services:5000/notify", {
        body: preBooking,
      });
      const notificationContent =
        "Booking ID: " + preBooking._id + "need to be located";
      console.log("content: ", notificationContent);

      await axios.post("http://notification-services:3009/", {
        title: "Locate Address",
        content: notificationContent,
        time: "2023-07-29T12:34:56Z",
        userId: "64f1aab3c8ecec186c0a2dde",
        deviceId: "5f4e8f16-1bf6-45a1-a882-8f7e90e16d20",
        type: "system",
      });

      return preBooking;
    } catch (err) {
      throw new Error(err.message);
    }
  },
  async updatePreBooking(preBookingId, updateFields) {
    try {
      return await PreBooking.findByIdAndUpdate(preBookingId, updateFields, {
        new: true,
      });
    } catch (err) {
      throw new Error(err.message);
    }
  },
  async deletePreBooking(preBookingId) {
    try {
      return await PreBooking.findByIdAndDelete(preBookingId);
    } catch (err) {
      throw new Error(err.message);
    }
  },
};

const BookingService = {
  async get_booking_list(filter, projection) {
    return Booking.find(filter).select(projection);
  },
  async get_history_booking(customerPhone) {
    return Booking.find({
      customerPhone: customerPhone,
    });
  },
  async get_booking_details(booking_id, populate_options) {
    const query = Booking.findById(booking_id);
    if (populate_options) {
      for (const field in populate_options) {
        if (field === "driverId") {
          query.populate({
            path: field,
            select: populate_options[field],
            populate: {
              path: "vehicleId",
            },
          });
        } else {
          // For other fields, apply the provided select options
          query.populate({
            path: field,
            select: populate_options[field],
          });
        }
      }
    }
    return await query.exec();
  },
  async get_most_location(customerPhone) {
    const result = await Booking.aggregate([
      {
        $match: {
          customerPhone: customerPhone,
        },
      },
      {
        $group: {
          _id: "$destinationLocation.address",
          count: { $sum: 1 },
          coordinate: { $first: "$destinationLocation.coordinate" },
        },
      },
      {
        $sort: { count: -1 },
      },
      {
        $limit: 5,
      },
      {
        $project: {
          _id: 0, // Exclude the _id field
          coordinate: 1, // Include the coordinate field
          address: "$_id", // Rename _id to address
          // count: 1, // Include the count field
        },
      },
    ]);
    return result;
  },
  async create_booking(booking_data) {
    try {
      const booking = new Booking(booking_data);
      await booking.save();
      return booking;
    } catch (err) {
      throw new Error(err.message);
    }
  },
  async update_booking(booking_id, update_fields) {
    try {
      return await Booking.findByIdAndUpdate(booking_id, update_fields, {
        new: true,
      });
    } catch (err) {
      throw new Error(err.message);
    }
  },
  async delete_booking(booking_id) {
    try {
      return await Booking.findByIdAndDelete(booking_id);
    } catch (err) {
      throw new Error(err.message);
    }
  },
  async sendToBookingReception(data) {
    let connection = null;
    let channel = null;
    try {
      // Create connection
      connection = await amqp.connect(config.AMQP_URL);
      channel = await connection.createChannel();
      const exchangeName = config.EXCHANGE_NAME;
      const routingKey = config.RECEPTION_ROUTING_KEY;
      await channel.assertExchange(exchangeName, "direct", { durable: false });

      // Publish message
      const json_string_data = JSON.stringify(data);
      channel.publish(exchangeName, routingKey, Buffer.from(json_string_data));
      console.log(`[x] Sent to booking reception service`, json_string_data);
    } catch (error) {
      console.log("Error sending customer info:", error.message);
    }
    // // Close connection
    // setTimeout(async () => {
    //     if (channel) {
    //         await channel.close();
    //     }
    //     if (connection) {
    //         await connection.close();
    //     }
    // }, 5000)
  },
};

const UserService = {
  async get_user_by_id(user_id) {
    return User.findById(user_id);
  },
};

const MapService = {
  async get_query_places(input, location) {
    const response = await axios.get(
      process.env.GOOGLE_MAP_QUERY_AUTO_COMPLETE_URL,
      {
        params: {
          input: input,
          location: location, // User current location
          radius: process.env.GOOGLE_MAP_RADIUS,
          components: process.env.GOOGLE_MAP_COMPONENTS, // Region
          key: process.env.GOOGLE_API_KEY,
        },
      }
    );
    return response.data.predictions;
  },
  async get_text_search_places(query, location) {
    const response = await axios.get(process.env.GOOGLE_MAP_TEXT_SEARCH_URL, {
      params: {
        query: query,
        location: location, // User current location
        radius: process.env.GOOGLE_MAP_RADIUS,
        key: process.env.GOOGLE_API_KEY,
      },
    });
    console.log(response.data);
    return response.data;
  },
};

export { PreBookingService, BookingService, UserService, MapService };
