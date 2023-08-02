import mongoose from 'mongoose';
import User from './User.js';

const Schema = mongoose.Schema;
const ObjectId = Schema.ObjectId;

const DriverSchema = new Schema({
    driverLicense: {
        type: String,
    },
    vehicleId: {
        type: Schema.Types.ObjectId,
    },
    isActive: {
        type: Boolean,
        default: false,
    },
    isDisable: {
        type: Boolean,
        default: false,
    },
    rating: {
        type: Number,
        default: 10,
    },
});

export default User.discriminator('Driver', DriverSchema);
