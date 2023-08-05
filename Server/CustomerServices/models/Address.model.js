import mongoose from 'mongoose';
import User from './User.model.js';

const Schema = mongoose.Schema;

const AddressSchema = new Schema({
    user_id: {
        type: Schema.Types.ObjectId,
        required: true,
        ref: 'User',
    },
    name: {
        type: String,
        required: true,
    },
    type: {
        type: String,
        required: true,
        enum: ['personal', 'work'],
    },
    coordinate: {
        x: {
            type: Number,
            required: true,
        },
        y: {
            type: Number,
            required: true,
        },
    },
    formatted_address: {
        type: String,
        required: true,
    },
})

export default mongoose.model('Address', AddressSchema, 'addresses');
