import Booking from '../models/Booking.js';
import {User} from '../models/User.js';

const BookingService = {
    async get_booking_list(filter, projection) {
        return await Booking.find(filter).select(projection);
    },
    async get_booking_details(booking_id) {
        return await Booking.findById(booking_id);
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
    async delete_booking(booking_id){
        try {
            return await Booking.findByIdAndDelete(booking_id);
        } catch (err) {
            throw new Error(err.message);
        }
    }
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