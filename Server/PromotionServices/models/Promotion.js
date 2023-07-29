import mongoose from 'mongoose';

const Schema = mongoose.Schema;

const PromotionSchema = new Schema(
    {
        name: {
            type: String,
            required: true,
            default: '',
        },
        strategy: {
            type: String,
            required: true,
            default: '',
        },
        description: {
            type: String,
            required: true,
            default: '',
        },
        discount: {
            type: Number,
            required: true,
            default: 0,
        },
        startDate: {
            type: Date,
            required: true,
            default: Date.now(),
        },
        endDate: {
            type: Date,
            required: true,
            default: Date.now(),
        },
        usage_limit: {
            type: Number,
            required: true,
            default: 0,
        },
    },
    {
        timestamps: true,
    }
);

export default mongoose.model('Promotion', PromotionSchema);
