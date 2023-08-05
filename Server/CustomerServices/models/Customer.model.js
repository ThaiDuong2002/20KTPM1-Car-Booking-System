import mongoose from 'mongoose';
import User from './User.model.js';

const Schema = mongoose.Schema;

const CustomerSchema = new Schema({
    address: [
        {
            type: Schema.Types.ObjectId,
            ref: 'Address',
        },
    ],
    userType: {
        type: String,
        default: "standard",
        enum: ['standard', 'premium'],
    },
    isDisabled: {
        type: Boolean,
        default: false,
    },
})

export default User.discriminator('Customer', CustomerSchema);
