import mongoose from "mongoose";

const Schema = mongoose.Schema;

const VehicleTypeSchema = new Schema({
        name: {
            type: String,
            required: true,
        },
        capacity: {
            type: Number,
            require: true,
        }
    },
    {
        timestamps: true,
    }
);

export const VehicleType = mongoose.model('VehicleType', VehicleTypeSchema, 'vehicleTypes');