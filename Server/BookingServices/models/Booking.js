import mongoose from 'mongoose';

const Schema = mongoose.Schema;
const ObjectId = Schema.ObjectId;

const Booking = new Schema(
    {
        booking_user_id: {
            type: ObjectId,
            required: false,
            ref: 'User',
        },
        booking_driver_id: {
            type: ObjectId,
            required: true,
            ref: 'User',
        },
        customer_name: {
            type: String,
            default: null,
        },
        customer_phone: {
            type: String,
            default: null,
        },
        trip_type: {
            type: String,
            required: true,
        },
        trip_pickup_location: {
            address: {
                type: String,
                required: true,
            },
            coordinate: {
                x: {
                    type: Number,
                    required: true,
                },
                y: {
                    type: Number,
                    required: true,
                },
            },
        },
        trip_destination_location: {
            address: {
                type: String,
                required: true,
            },
            coordinate: {
                x: {
                    type: Number,
                    required: true,
                },
                y: {
                    type: Number,
                    required: true,
                },
            },
        },
        trip_distance: {
            type: Number,
            required: true,
        },
        trip_duration: {
            type: Number,
            required: true,
        },
        trip_pre_total: {
            type: Number,
            required: true,
        },
        trip_total: {
            type: Number,
            required: true,
        },
        trip_promotion_id: {
            type: ObjectId,
            required: false,
            ref: 'Promotion',
        },
        trip_status: {
            type: String,
            required: false,
            default: 'Pending',
        },
        trip_pickup_time: {
            type: Date,
            required: false,
            default: Date.now(),
        },
        trip_dropoff_time: {
            type: Date,
            required: false,
            default: Date.now(),
        },
        booking_payment_method_id: {
            type: ObjectId,
            required: true,
            ref: 'PaymentMethod',
        },
        booking_refund_id: {
            type: ObjectId,
            required: false,
            ref: 'Refund',
        },
        booking_ratings: {
            user_id: {
                type: ObjectId,
                required: false,
                ref: 'User',
            },
            comment: {
                type: String,
                default: '',
            },
            time: {
                type: Date,
                default: Date.now(),
            },
            star: {
                type: Number,
                default: 5,
            },
        },
    },
    {
        timestamps: true,
    });

export default mongoose.model('Booking', Booking, "bookings");
