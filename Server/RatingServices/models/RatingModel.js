import mongoose from 'mongoose';

const Schema = mongoose.Schema;

const RatingSchema = new Schema(
    {
        userId: {
            type: Schema.Types.ObjectId,
            ref: 'User',
            required: true,
        },
        driverId: {
            type: Schema.Types.ObjectId,
            ref: 'User',
            required: true,
        },
        star: {
            type: Number,
            required: true,
        },
    },
    {
        timestamps: true,
    }
);

export const Rating = mongoose.model('Rating', RatingSchema, 'ratings');
