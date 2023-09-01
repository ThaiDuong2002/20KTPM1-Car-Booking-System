import mongoose from 'mongoose';

const Schema = mongoose.Schema;

const BookingSchema = new Schema(
    {
        userId: {
            type: Schema.Types.ObjectId,
            required: false,
            ref: 'User',
        },
        driverId: {
            type: Schema.Types.ObjectId,
            required: true,
            ref: 'User',
        },
        customerName: {
            type: String,
            default: null,
        },
        customerPhone: {
            type: String,
            default: null,
        },
        type: {
            type: String,
            required: true,
            enum : ['Motorbike','Car'],
        },
        pickupLocation: {
            address: {
                type: String,
                required: true,
            },
            coordinate: {
                lat: { // x
                    type: Number,
                    required: true,
                },
                lng: { // y
                    type: Number,
                    required: true,
                },
            },
        },
        destinationLocation: {
            address: {
                type: String,
                required: true,
            },
            coordinate: {
                lat: { // x
                    type: Number,
                    required: true,
                },
                lng: { // y
                    type: Number,
                    required: true,
                },
            },
        },
        distance: {
            type: Number,
            required: true,
        },
        preTotal: {
            type: Number,
            required: true,
        },
        total: {
            type: Number,
            required: true,
        },
        promotionId: {
            type: Schema.Types.ObjectId,
            required: false,
            ref: 'Promotion',
        },
        status: {
            type: String,
            default: 'Pending',
            enum : ['Pending','Confirm','In-progress','Completed','Cancel','Pre-book']
        },
        pickupTime: {
            type: Date,
            default: Date.now(),
        },
        dropOffTime: {
            type: Date,
            default: Date.now(),
        },
        paymentMethodId: {
            type: Schema.Types.ObjectId,
            required: true,
            ref: 'PaymentMethod',
        },
        refundId: {
            type: Schema.Types.ObjectId,
            ref: 'Refund',
        },
    },
    {
        timestamps: true,
    });

export const Booking = mongoose.model('Booking', BookingSchema, "bookings");
