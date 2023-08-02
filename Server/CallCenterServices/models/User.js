import mongoose from 'mongoose';

const Schema = mongoose.Schema;

const UserSchema = new Schema({
        firstname: {
            type: String,
            required: true,
        },
        lastname: {
            type: String,
            required: true,
        },
        email: {
            type: String,
            required: true,
        },
        phone: {
            type: String,
            required: true,
        },
        password: {
            type: String,
            required: true,
        },
        avatar: {
            type: String,
            default: "https://haycafe.vn/wp-content/uploads/2022/02/Avatar-trang-den.png",
        },
        dob: {
            type: Date,
        },
        role: {
            type: String,
            required: true,
            enum: ['admin', 'customer', 'consultant', 'driver'],
        },
        gender: {
            type: String,
            enum: ['male', 'female', 'other'],
            restrictToFunctions: ['update'],
        },
        refreshToken: {
            type: String,
            default: '',
        }
    },
    {
        timestamps: true,
    }
);

export default mongoose.model('User', UserSchema);
