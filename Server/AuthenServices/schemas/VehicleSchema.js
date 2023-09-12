import mongoose from "mongoose";

const Schema = mongoose.Schema;

const VehicleSchema = new Schema({
        color: {
            type: String,
            required: true,
        },
        licensePlate: {
            type: String,
            required: true,
        },
        image: {
            type: String,
            required: true,
        },
        typeId: {
            type: Schema.Types.ObjectId,
            required: true,
        },
    },
    {
        timestamps: true,
    }
);

const MotorbikeSchema = new Schema(VehicleSchema);

const CarSchema = new Schema(VehicleSchema);
CarSchema.add({
    capacity: {
        type: Number,
        required: true,
    },
});

const VehicleModel = mongoose.model('Vehicle', VehicleSchema, 'vehicles');
const MotorbikeModel = VehicleModel.discriminator('Motorbike', MotorbikeSchema);
const CarModel = VehicleModel.discriminator('Car', CarSchema);

export {
    VehicleModel,
    MotorbikeModel,
    CarModel,
}