import {Booking, PreBooking} from "../models/BookingModel.js";
import {User} from "../models/UserModel.js";
import {Vehicle} from "../models/VehicleModel.js";
import {Promotion} from "../models/PromotionModel.js";
import {PaymentMethod} from "../models/PaymentMethodModel.js";
import {Refund} from "../models/RefundModel.js";

import axios from "axios";
import amqp from "amqplib";
import dotenv from "dotenv";

dotenv.config();

const config = process.env;

const PreBookingService = {
    async getPreBookingList(filter, projection) {
        return PreBooking.find(filter).select(projection);
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
            return preBooking;
        } catch (err) {
            throw new Error(err.message);
        }
    },
    async updatePreBooking(preBookingId, updateFields) {
        try {
            return await PreBooking.findByIdAndUpdate(
                preBookingId,
                updateFields,
                {
                    new: true,
                }
            );
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
                if (field === "driverId"){
                    query.populate({
                        path: field,
                        select: populate_options[field],
                        populate: {
                            path: "vehicleId",
                        }
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
    async get_most_location (customerPhone) {
        const result = await Booking.aggregate([
            {
                $match: {
                    customerPhone: customerPhone,
                },
            },
            {
                $group: {
                    _id: '$destinationLocation.address',
                    count: { $sum: 1},
                    coordinate: { $first: '$destinationLocation.coordinate' },
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
                    address: '$_id', // Rename _id to address
                    // count: 1, // Include the count field
                },
            },
        ])
        return result
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
        // Create connection
        const connection = await amqp.connect(config.AMQP_URL);
        const channel = await connection.createChannel();
        const exchangeName = config.EXCHANGE_NAME;
        const routingKey = config.RECEPTION_ROUTING_KEY;
        await channel.assertExchange(exchangeName, "direct", {durable: false});

        // Publish message
        channel.publish(exchangeName, routingKey, Buffer.from(JSON.stringify(data)));
        console.log(`[x] Sent to booking reception service`, data);

        // Close connection
        setTimeout(() => {
            connection.close();
        }, 500);
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

export {PreBookingService, BookingService, UserService, MapService};
