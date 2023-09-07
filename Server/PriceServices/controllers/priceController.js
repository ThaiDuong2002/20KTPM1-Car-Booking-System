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
            // Create price
            const price_re = await PriceService.create_price(priceInfo);
            res.status(201).json({
                message: 'Create price successfully',
                status: 200,
                data: price_re,
            })
        } catch (err) {
            next(createError.InternalServerError(err.message));
        }
    },
    calculate_fee: async (req, res, next) => {
        try {
            const {distance, time, tripType} = req.body;
            const totalFare = await PriceService.get_calculate_fee(distance, time, tripType);
            res.status(200).json({
                message: 'Calculate fee successfully',
                status: 200,
                data: {
                    totalFare: totalFare
                },
            })
        } catch (err) {
            console.log(err.message)
            next(createError.InternalServerError(err.message));
        }
    },
};

export default PriceController;
