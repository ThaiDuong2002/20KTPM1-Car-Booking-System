import mongoose from 'mongoose';

const Schema = mongoose.Schema;
const ObjectId = Schema.ObjectId;

const Booking = new Schema(
  {
    user_id: {
      type: ObjectId,
      required: true,
    },
    driver_id: {
      type: ObjectId,
      required: true,
    },
    pickup_location: {
      type: {
        address: {
          type: String,
          required: true,
          default: '',
        },
        coordinate: {
          type: {
            x: {
              type: Number,
              required: true,
              default: 0,
            },
            y: {
              type: Number,
              required: true,
              default: 0,
            },
          },
        },
      },
    },
    destination_location: {
      type: {
        address: {
          type: String,
          required: true,
          default: '',
        },
        coordinate: {
          type: {
            x: {
              type: Number,
              required: true,
              default: 0,
            },
            y: {
              type: Number,
              required: true,
              default: 0,
            },
          },
        },
      },
    },
    fare: {
      type: Number,
      required: true,
      default: 0,
    },
    promotion_id: {
      type: ObjectId,
      required: false,
      default: null,
    },
    payment_method_id: {
      type: ObjectId,
      required: true,
      ref: 'PaymentMethod',
    },
    status: {
      type: String,
      required: true,
      default: 'pending',
    },
    pickup_time: {
      type: Date,
      required: true,
      default: Date.now(),
    },
    dropoff_time: {
      type: Date,
      required: false,
      default: null,
    },
    refund_id: {
      type: Number,
      required: false,
      default: null,
    },
    rating: {
      type: {
        comment: {
          type: String,
          required: false,
          default: '',
        },
        score: {
          type: Number,
          required: true,
          default: 0,
        },
      },
    },
  },
  {
    timestamps: true,
  }
);

export default mongoose.model('Booking', Booking, "bookings");
