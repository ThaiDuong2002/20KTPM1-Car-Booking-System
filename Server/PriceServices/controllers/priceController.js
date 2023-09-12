import createError from 'http-errors'
import {PriceService} from '../services/services.js';

const PriceController = {
    get_price_list: async (req, res, next) => {
        try {
            let filter = req.body
            const list = await PriceService.get_price_list(filter, {});
            if (!list) {
                return next(createError.BadRequest("Get list failed"));
            }
            if (list.length === 0) {
                return next(createError.NotFound("No Price found"));
            }
            res.json({
                message: 'Get prices list successfully',
                status: 200,
                data: list,
            })
        } catch (err) {
            next(createError.InternalServerError(err.message));
        }
    },
    get_price_details: async (req, res, next) => {
        try {
            const priceId = req.params.id
            const price = await PriceService.get_price_details(priceId);
            if (!price) {
                return next(createError.NotFound("Price not found"));
            }
            res.json({
                message: 'Get price details successfully',
                status: 200,
                data: price,
            })
        } catch (err) {
            next(createError.InternalServerError(err.message));
        }
    },
    create_price: async (req, res, next) => {
        try {
            const priceInfo = req.body;
            // Check if price type is existed
            const price = await PriceService.get_price_by_type_name(priceInfo.type);
            if (price) {
                return next(createError.Conflict("Price type is existed"));
            }

            // Create price
            const price_re = await PriceService.create_price(priceInfo);
            if (!price_re) {
                return next(createError.Conflict("Create price failed"));
            }
            res.status(201).json({
                message: 'Create price successfully',
                status: 200,
                data: price_re,
            })
        } catch (err) {
            next(createError.InternalServerError(err.message));
        }
    },
    update_price: async (req, res, next) => {
        try {
            const priceId = req.params.id;
            const priceInfo = req.body;
            
            // Check if price type is existed
            const price = await PriceService.get_price_details(priceId);
            if (!price) {
                return next(createError.NotFound("Price not found"));
            }

            // Update price
            const updatedPrice = await PriceService.updatePrice(priceId, priceInfo);
            if (!updatedPrice) {
                return next(createError.NotFound("Update price failed"));
            }
            res.status(200).json({
                message: 'Update price successfully',
                status: 200,
                data: updatedPrice,
            })
        } catch (err) {
            next(createError.InternalServerError(err.message));
        }
    },
    delete_price: async (req, res, next) => {
        try {
            const priceId = req.params.id;

            // Check if price type is existed
            const price = await PriceService.get_price_details(priceId);
            if (!price) {
                return next(createError.NotFound("Price not found"));
            }

            // Delete price
            const deletedPrice = await PriceService.deletePrice(priceId);
            if (!deletedPrice) {
                return next(createError.NotFound("Delete price failed"));
            }
            res.status(200).json({
                message: 'Delete price successfully',
                status: 200,
                data: deletedPrice,
            })
        } catch (err) {
            next(createError.InternalServerError(err.message));
        }
    },
    calculate_fee: async (req, res, next) => {
        try {
            const {distance, time, tripType, badWeather} = req.body;
            const fareInfo = await PriceService.get_calculate_fee(distance, time, tripType, badWeather);

            res.status(200).json({
                message: 'Calculate fee successfully',
                status: 200,
                data: {
                    totalFare: fareInfo.totalFare,
                    rulesApplied: fareInfo.rulesApplied,
                    tripType: tripType,
                },
            })
        } catch (err) {
            next(createError.InternalServerError(err.message));
        }
    },
};

export default PriceController;
