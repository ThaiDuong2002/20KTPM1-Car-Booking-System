import createError from 'http-errors';
import {VehicleType} from "../schemas/VehicleTypeSchema.js";
import {
    CarFactory,
    MotorbikeFactory,
} from '../models/VehicleFactory.js';

const VehicleServices = {
    async getVehicleTypeNameById(typeId) {
        const vehicleType =  await VehicleType.findOne({_id: typeId})
        return vehicleType.name;
    },
    async createVehicle(vehicleInfo) {
        const typeName = await VehicleServices.getVehicleTypeNameById(vehicleInfo.typeId)
        let newVehicle
        switch (typeName) {
            case "Car":
                newVehicle = new CarFactory().createVehicle(vehicleInfo)
                break
            case "Motorbike":
                newVehicle = new MotorbikeFactory().createVehicle(vehicleInfo)
                break
            default:
                throw createError.BadRequest("Invalid vehicle type")
        }
        // Save to DB
        return await newVehicle.saveToDB()
    },
}

export default VehicleServices