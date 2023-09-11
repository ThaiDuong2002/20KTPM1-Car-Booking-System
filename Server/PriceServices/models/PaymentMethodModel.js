import mongoose from 'mongoose';

const Schema = mongoose.Schema;

const PaymentMethodSchema = new Schema(
    {
        name: {
            type: String,
            required: true,
        },
    },
    {
        timestamps: true,
    }
);

export const PaymentMethod = mongoose.model('PaymentMethod', PaymentMethodSchema, 'paymentMethods');
