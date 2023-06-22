import mongoose from 'mongoose';

const Schema = mongoose.Schema;

const Promotion = new Schema(
  {
    name: {
      type: String,
      required: true,
      default: '',
    },
    description: {
      type: String,
      required: true,
      default: '',
    },
    discount: {
      type: Number,
      required: true,
      default: 0,
    },
    start_date: {
      type: Date,
      required: true,
      default: Date.now(),
    },
    end_date: {
      type: Date,
      required: true,
      default: Date.now(),
    },
  },
  {
    timestamps: true,
  }
);

export default mongoose.model('Promotion', Promotion);
