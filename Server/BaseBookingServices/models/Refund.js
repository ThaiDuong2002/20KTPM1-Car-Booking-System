import mongoose from 'mongoose';

const Schema = mongoose.Schema;
const ObjectId = Schema.ObjectId;

const RefundSchema = new Schema(
    {
        booking_id: {
            type: ObjectId,
            required: true,
            ref: 'Booking',
        },
        amount: {
            type: Number,
            required: true,
        },
        date: {
            type: Date,
            default: Date.now,
        },
        reason: {
            type: String,
            default: ''
        },
        status: {
            type: String,
            default: 'pending'
        },
        user_id: {
            type: ObjectId,
            required: true,
            ref: 'User',
        }
    },
    {
        timestamps: true,
    }
);

export default mongoose.model('Refund', RefundSchema, 'refunds');
