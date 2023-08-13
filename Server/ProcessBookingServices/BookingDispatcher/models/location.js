import mongoose from 'mongoose';

const Schema = mongoose.Schema;

const LocationSchema = new Schema(
    {
        driver_id: {
            type: Schema.Types.ObjectId,
            required: true,
            ref: 'User',
        },
        location: {
            x: {
                type: Number,
                required: true,
            },
            y: {
                type: Number,
                required: true,
            }
        }
    },
    {
        timestamps: true,
    });

export default mongoose.model('Location', LocationSchema, "locations");
