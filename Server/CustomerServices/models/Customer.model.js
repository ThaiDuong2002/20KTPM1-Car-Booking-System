import mongoose from 'mongoose';
import User from './User.model.js';

const Schema = mongoose.Schema;

const Customer = new Schema({
    address: {
        type: [
            {
                name: {
                    type: String,
                    required: true,
                    default: '',
                },
                type: {
                    type: String,
                    required: true,
                    default: '',
                },
            },
        ],
    },
    userType: {
        type: Boolean,
        required: true,
        default: false,
    },
    isDisabled: {
        type: Boolean,
        required: true,
        default: false,
    },
});

export default User.discriminator('Customer', Customer);
