import mongoose from 'mongoose';

const Schema = mongoose.Schema;

const PriceSchema = new Schema(
    {
        baseFare: {
            type: Number,
            required: true,
        },
        distanceFare: {
            type: Number,
            required: true,
        },
        timeFare: {
            type: Number,
            required: true,
        },
        promotionId: {
            type: Schema.Types.ObjectId,
            ref: 'Promotion',
        },
        totalFare: {
            type: Number,
            required: true,
        },
    },
    {
        timestamps: true,
    }
);

export const Price = mongoose.model('Price', PriceSchema, "prices");
