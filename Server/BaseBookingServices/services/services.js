import Booking from '../models/Booking.js';
import User from '../models/User.js';
import Promotion from '../models/Promotion.js';
import PaymentMethod from '../models/PaymentMethod.js';
import Refund from '../models/Refund.js';
import axios from "axios";

const BookingService = {
    async get_booking_list(filter, projection) {
        return await Booking.find(filter).select(projection);
    },
    async get_booking_details(booking_id, populate_options) {
        const query = Booking.findById(booking_id);

        if (populate_options) {
            for (const field in populate_options) {
                query.populate({
                    path: field,
                    select: populate_options[field]
                });
            }
        }

        return await query.exec();
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
            return await Booking.findByIdAndUpdate(
                booking_id,
                update_fields,
                {new: true});
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
    }
}

const UserService = {
    async get_user_by_id(user_id) {
        return await User.findById(user_id);
    },
}

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
        return response.data.predictions
    },
    async get_text_search_places(query, location) {
        const response = await axios.get(
            process.env.GOOGLE_MAP_TEXT_SEARCH_URL,
            {
                params: {
                    query: query,
                    location: location, // User current location
                    radius: process.env.GOOGLE_MAP_RADIUS,
                    key: process.env.GOOGLE_API_KEY,
                }
            }
        );
        console.log(response.data)
        return response.data
    }
}

export {
    BookingService,
    UserService,
    MapService,
}