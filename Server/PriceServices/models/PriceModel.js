import mongoose from 'mongoose';

const Schema = mongoose.Schema;

const PriceSchema = new Schema(
    {
        type: {
            type: String,
            required: true,
        },
        baseFare: {
            type: Number,
            required: true,
        },
        distanceFare: {
            type: Number,
            required: true,
        },
    },
    {
        timestamps: true,
    }
);

export const Price = mongoose.model('Price', PriceSchema, "prices");
