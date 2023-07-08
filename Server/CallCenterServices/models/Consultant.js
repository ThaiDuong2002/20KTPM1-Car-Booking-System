import mongoose from 'mongoose';
import User from './User.js';

const Schema = mongoose.Schema;

const Consultant = new Schema({
  salary: {
    type: Number,
    required: true,
    default: 0,
  },
});

export default User.discriminator('Consultant', Consultant);
