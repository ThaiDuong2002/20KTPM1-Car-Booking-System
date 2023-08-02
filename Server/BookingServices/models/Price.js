import mongoose from 'mongoose';

const Schema = mongoose.Schema;

const PriceSchema = new Schema(
    {
        value: {
            type: Number,
            default: 0,
        },
        strategy: {
            type: String,
            required: true,
        },
        booking_id: {
            type: Schema.Types.ObjectId,
            required: true,
            ref: 'bookings',
        },
        base_fare: {
            type: Number,
            required: true,
        },
        distance_fare: {
            type: Number,
            required: true,
        },
        time_fare: {
            type: Number,
            required: true,
        },
        promotion_discount: {
            type: Schema.Types.ObjectId,
            ref: 'promotions',
        },
        total_fare: {
            type: Number,
            required: true,
        },
        surge_multiplier: {
            type: Number,
            required: true,
        },
    },
    {
        timestamps: true,
    }
);

export default mongoose.model('Price', PriceSchema, "prices");
