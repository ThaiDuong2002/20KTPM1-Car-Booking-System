import mongoose from 'mongoose';
import {User} from './UserModel.js';

const Schema = mongoose.Schema;

const AddressSchema = new Schema({
    userId: {
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
        enum: ['Personal', 'Work'],
    },
    coordinate: {
        lat: {
            type: Number,
            required: true,
        },
        lng: {
            type: Number,
            required: true,
        },
    },
    formattedAddress: {
        type: String,
        required: true,
    },
})

export default mongoose.model('Address', AddressSchema, 'addresses');