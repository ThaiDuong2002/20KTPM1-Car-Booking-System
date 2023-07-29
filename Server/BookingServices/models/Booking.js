import mongoose from 'mongoose';

const Schema = mongoose.Schema;
const ObjectId = Schema.ObjectId;

const Booking = new Schema(
    {
        booking_user_id: {
            type: ObjectId,
            required: false,
        },
        booking_driver_id: {
            type: ObjectId,
            required: true,
        },
        booking_consultant_id: {
            type: ObjectId,
            required: false,
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
            ref: 'payment_methods',
        },
        booking_refund_id: {
            type: ObjectId,
            required: false,
            ref: 'refunds',
        },
        // booking_ratings: {
        //     user_id: {
        //         type: ObjectId,
        //         required: false,
        //         default: null,
        //     },
        //     comment: {
        //         type: String,
        //         required: false,
        //         default: '',
        //     },
        //     time: {
        //         type: Date,
        //         required: false,
        //         default: Date.now(),
        //     },
        //     star: {
        //         type: Number,
        //         required: false,
        //         default: 5,
        //     },
        // },
        booking_ratings: {
            user_id: {
                type: ObjectId,
                required: false,
            },
            comment: {
                type: String,
                required: false,
            },
            time: {
                type: Date,
                required: false,
            },
            star: {
                type: Number,
                required: false,
            },
        },
    },
    {
        timestamps: true,
    });

export default mongoose.model('Booking', Booking, "bookings");
