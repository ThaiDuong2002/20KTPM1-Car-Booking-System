import mongoose from 'mongoose';

const Schema = mongoose.Schema;

const RefundSchema = new Schema(
    {
        bookingId: {
            type: Schema.Types.ObjectId,
            required: true,
            ref: 'Booking',
        },
        userId: {
            type: Schema.Types.ObjectId,
            required: true,
            ref: 'User',
        },
        amount: {
            type: Number,
            default: 0
        },
        status: {
            type: String,
            default: 'pending',
            enum: ['pending', 'approved', 'rejected']
        },
    },
    {
        timestamps: true,
    }
);

export const Refund = mongoose.model('Refund', RefundSchema, 'refunds');
