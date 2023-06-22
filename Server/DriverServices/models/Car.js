import mongoose from 'mongoose';
import Vehicle from './Vehicle.js';

const Schema = mongoose.Schema;

const Car = new Schema({
  capacity: {
    type: Number,
    required: true,
  },
});

export default Vehicle.discriminator('Car', Car);
