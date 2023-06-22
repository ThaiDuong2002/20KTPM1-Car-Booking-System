import mongoose from 'mongoose';
import User from './User.js';

const Schema = mongoose.Schema;
const ObjectId = Schema.ObjectId;

const Driver = new Schema({
  driverLicense: {
    type: String,
    required: true,
    trim: true,
    default: '',
  },
  vehicleId: {
    type: ObjectId,
    required: true,
    default: null,
    ref: 'Vehicle',
  },
  isActive: {
    type: Boolean,
    required: true,
    default: true,
  },
  isDisable: {
    type: Boolean,
    required: true,
    default: false,
  },
  rating: {
    type: Number,
    required: true,
    default: 10,
  },
});

export default User.discriminator('Driver', Driver);
