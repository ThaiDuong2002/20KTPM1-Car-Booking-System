import mongoose from 'mongoose';
import User from './User';

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
    type: String,
    required: true,
  },
  isDisable: {
    type: Boolean,
    required: true,
    default: false,
  },
});

export default User.discriminator('Customer', Customer);
