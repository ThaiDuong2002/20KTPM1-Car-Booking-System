import mongoose from "mongoose";

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
        userRole: {
            type: String,
            required: true,
            enum: ['admin', 'customer', 'consultant', 'driver'],
        },
        gender: {
            type: String,
            enum: ['male', 'female', 'other'],
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

const AdminSchema = new Schema(UserSchema);

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
            type: Schema.Types.ObjectId,
            ref: 'Address',
        },
    ],
    userType: {
        type: String,
        default: "Standard",
        enum: ['Standard', 'Premium'],
    },
    isDisabled: {
        type: Boolean,
        default: false,
    },
});

const DriverSchema = new Schema(UserSchema);
DriverSchema.add({
    driverLicense: [
        {
            type: String,
            required: true,
        },
    ],
    vehicleId: {
        type: Schema.Types.ObjectId,
        required: true,
    },
    isActive: {
        type: Boolean,
        default: true,
    },
    isDisabled: {
        type: Boolean,
        default: false,
    },
    isValid: {
        type: Boolean,
        default: false,
    },
    rating: {
        type: Schema.Types.ObjectId,
    },
});

export const User = mongoose.model('User', UserSchema);
export const Admin = User.discriminator('Admin', AdminSchema);
export const Consultant = User.discriminator('Consultant', ConsultantSchema);
export const Customer = User.discriminator('Customer', CustomerSchema);
export const Driver = User.discriminator('Driver', DriverSchema);
