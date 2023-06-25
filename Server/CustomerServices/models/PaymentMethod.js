import mongoose from 'mongoose';

const Schema = mongoose.Schema;

const PaymentMethod = new Schema(
  {
    name: {
      type: String,
      required: true,
      default: '',
    },
  },
  {
    timestamps: true,
  }
);

export default mongoose.model('PaymentMethod', PaymentMethod);
