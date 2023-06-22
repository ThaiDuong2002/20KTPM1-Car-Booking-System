import mongoose from 'mongoose';
import User from './User.js';

const Schema = mongoose.Schema;
const ObjectId = Schema.ObjectId;

const Driver = new Schema({
  driver_license: {
    type: String,
    required: true,
    trim: true,
    default: '',
  },
  vehicle_id: {
    type: ObjectId,
    required: true,
    default: null,
    ref: 'Vehicle',
  },
  is_active: {
    type: Boolean,
    required: true,
    default: true,
  },
  is_disabled: {
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
