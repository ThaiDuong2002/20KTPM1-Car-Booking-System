import mongoose from 'mongoose';
import User from './User.js';

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
    user_type: {
        type: Boolean,
        required: true,
        default: false,
    },
    is_disabled: {
        type: Boolean,
        required: true,
        default: false,
    },
});

export default User.discriminator('Customer', Customer);
