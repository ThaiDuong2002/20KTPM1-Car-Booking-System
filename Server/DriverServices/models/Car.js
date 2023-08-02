import mongoose from 'mongoose';
import Vehicle from './Vehicle.js';

const Schema = mongoose.Schema;

const CarSchema = new Schema({
    capacity: {
        type: Number,
        required: true,
    },
    type: {
        type: String,
        required: true,
    },
});

export default Vehicle.discriminator('Car', CarSchema);
