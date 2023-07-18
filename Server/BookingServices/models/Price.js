import mongoose from 'mongoose';

const Schema = mongoose.Schema;

const Price = new Schema(
  {
    value: {
      type: Number,
      required: true,
      default: 0,
    },
  },
  {
    timestamps: true,
  }
);

export default mongoose.model('Price', Price, "prices");
