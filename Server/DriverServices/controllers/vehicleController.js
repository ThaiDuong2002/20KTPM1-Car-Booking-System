import createError from "http-errors";
import {VehicleService} from "../services/services.js";

const VehicleController = {
    get_vehicle_type_list: async (req, res, next) => {
        const filter = req.body;
        const list = await VehicleService.getVehicleTypeList(filter, 'name capacity');
        if (!list) {
            return next(createError(404, 'Vehicle type list not found'));
        }

        res.status(200).json({
            message: "Get vehicle type list successfully",
            status: 'success',
            data: list
        });
    },
    get_vehicle_type: async (req, res, next) => {
        const id = req.params.id;
        const vehicleType = await VehicleService.getVehicleType(id);
        if (!vehicleType) {
            return next(createError(404, 'Vehicle type not found'));
        }
        res.status(200).json({
            message: "Get vehicle type successfully",
            status: 'success',
            data: vehicleType
        });
    },
    add_vehicle_type: async (req, res, next) => {
        const {name, capacity} = req.body;
        const vehicleType = await VehicleService.addVehicleType(name, capacity);
        if (!vehicleType) {
            return next(createError(400, 'Add vehicle type failed'));
        }
        res.status(200).json({
            message: "Add vehicle type successfully",
            status: 'success',
            data: vehicleType
        });
    },
    update_vehicle_type: async (req, res, next) => {
        const id = req.params.id;
        const {name, capacity} = req.body;
        const vehicleType = await VehicleService.updateVehicleType(id, name, capacity);
        if (!vehicleType) {
            return next(createError(400, 'Update vehicle type failed'));
        }
        res.status(200).json({
            message: "Update vehicle type successfully",
            status: 'success',
            data: vehicleType,
        });
    },
    delete_vehicle_type: async (req, res, next) => {
        const id = req.params.id;
        const vehicleType = await VehicleService.deleteVehicleType(id);
        if (!vehicleType) {
            return next(createError(400, 'Delete vehicle type failed'));
        }
        res.status(200).json({
            message: "Delete vehicle type successfully",
            status: 'success',
            data: vehicleType,
        });
    },
}

export default VehicleController;