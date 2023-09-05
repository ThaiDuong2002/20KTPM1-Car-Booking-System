import createError from "http-errors";
import {VehicleService} from "../services/services.js";

const VehicleController = {
    get_vehicle_type_list: async (req, res, next) => {
        const list = await VehicleService.getVehicleTypeList();
        if (!list) {
            return next(createError(404, 'Vehicle type list not found'));
        }

        res.status(200).json({
            message: "Get vehicle type list successfully",
            status: 'success',
            data: list
        });
    }
}

export default VehicleController;