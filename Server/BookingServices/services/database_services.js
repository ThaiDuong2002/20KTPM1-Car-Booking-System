import Booking from '../models/Booking.js';
import { User } from '../models/User.js';

const BookingService = {
    async get_bookings_list() {
        const bookings = await Booking.find();
        return bookings;
    },
    async get_booking_details(booking_id) {
        const booking = await Booking.findById(booking_id);
        return booking;
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
            const update_result = Booking.findOneAndUpdate(
                { _id: booking_id },
                update_fields,
                { new: true });
            return update_result;
        } catch (err) {
            throw new Error(err.message);
        }
    },
}

const UserService = {
    async get_user_by_id(user_id) {
        const result = User.findById(user_id);
        return result;
    },
}

export {
    BookingService,
    UserService
}