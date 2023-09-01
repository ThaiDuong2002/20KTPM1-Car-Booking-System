import createError from 'http-errors';
import {Car, Motorbike} from "../models/VehicleModel.js";
import {VehicleType} from "../models/VehicleTypeModel.js";

const VehicleServices = {
    async getVehicleTypeNameById(typeId) {
        const vehicleType =  await VehicleType.findOne({_id: typeId})
        return vehicleType.name;
    },
    async createVehicle(data) {
        const typeName = await VehicleServices.getVehicleTypeNameById(data.typeId)
        let newVehicle
        switch (typeName) {
            case "Car":
                newVehicle = new Car(data)
                break
            case "Motorbike":
                newVehicle = new Motorbike(data)
                break
            default:
                throw createError.BadRequest("Invalid vehicle type")
        }
        const result = await newVehicle.save()
        if (!result) {
            throw createError.BadRequest("Create vehicle failed")
        }
        return result._id
    },
}

export default VehicleServices