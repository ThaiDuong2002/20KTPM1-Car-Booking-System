import mongoose from 'mongoose';

const Schema = mongoose.Schema;

const PromotionSchema = new Schema(
    {
        name: {
            type: String,
            required: true,
        },
        description: {
            type: String,
            required: true,
        },
        discount: {
            type: Number,
            default: 0,
        },
        startDate: {
            type: Date,

            default: Date.now(),
        },
        endDate: {
            type: Date,
            default: Date.now(),
        },
        usageLimit: {
            type: Number,
            default: 0,
        },
    },
    {
        timestamps: true,
    }
);

export const Promotion = mongoose.model('Promotion', PromotionSchema, 'promotions');
