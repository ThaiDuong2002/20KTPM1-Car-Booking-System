import mongoose from 'mongoose';

const Schema = mongoose.Schema;
const ObjectId = Schema.ObjectId;

const Notification = new Schema(
    {
        title: {
            type: String,
            required: true,
            default: '',
        },
        content: {
            type: String,
            required: true,
            default: '',
        },
        time: {
            type: Date,
            required: true,
            default: Date.now(),
        },
        user_id: {
            type: ObjectId,
            required: true,
            ref: 'User',
        },
        device_id: {
            type: String,
            required: true,
        },
        is_read: {
            type: Boolean,
            required: true,
            default: false
        },
        type: {
            type: String,
            required: true,
            default: 'system',
        },
    },
    {
        timestamps: true,
    });

export default mongoose.model('Notification', Notification);
