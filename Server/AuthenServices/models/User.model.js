import mongoose from "mongoose";
import db from '../configs/db.js';
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
    refreshToken: {
        type: String,
        default: 'null',
    }
});

const AdminSchema = new Schema(UserSchema);
AdminSchema.add({
    // other admin-specific fields
});

const ConsultantSchema = new Schema(UserSchema);
ConsultantSchema.add({
    salary: {
        type: Number,
        default: 0,
    },

});

const CustomerSchema = new Schema(UserSchema);
CustomerSchema.add({
    address: [
        {
            name: String,
            type: String,
        }
    ],
    userType: {
        type: String,
        default: "standard",
    },
    isDisable: {
        type: Boolean,
        default: false,
    },
});

const DriverSchema = new Schema(UserSchema);
DriverSchema.add({
    driverLicense: String,
    vehicleId: Schema.Types.ObjectId,
    isActive: {
        type: Boolean,
        default: false,
    },
    isDisable: {
        type: Boolean,
        default: false,
    },
    rating: {
        type: Number,
        default: 10,
    },
});

export const User = mongoose.model('users', UserSchema);
export const Admin = User.discriminator('admins', AdminSchema);
export const Consultant = User.discriminator('consultants', ConsultantSchema);
export const Customer = User.discriminator('customers', CustomerSchema);
export const Driver = User.discriminator('drivers', DriverSchema);
