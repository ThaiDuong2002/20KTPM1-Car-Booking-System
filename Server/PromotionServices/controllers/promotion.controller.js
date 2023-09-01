import createError from 'http-errors'
import {PromotionService} from '../services/database_services.js';
import {
    create_promotion_schema,
    update_promotion_schema} from '../middlewares/validate.js';

const PromotionController = {
    async add_promotion(req, res, next) {
        try {
            const promotionInfo = req.body;
            // const {error, value} = create_promotion_schema.validate(req.body);
            // if (error) {
            //     return next(createError.BadRequest(error.details[0].message))
            // }
            // Create promotion
            const promotion_re = await PromotionService.create_promotion(promotionInfo);
            res.status(201).json({
                message: 'Add promotion successfully',
                status: 200,
                data: promotion_re,
            })
        } catch (err) {
            return next(createError.InternalServerError(err.message));
        }
    },
    async get_promotion_details(req, res, next) {
        try {
            const promotion_id = req.params.id
            const promotion = await PromotionService.get_promotion_details(promotion_id);
            if (!promotion) {
                return next(createError.NotFound("Promotion not found"));
            }
            res.json({
                message: 'Get promotion details successfully',
                status: 200,
                data: promotion,
            })
        } catch (err) {
            next(createError.InternalServerError(err.message));
        }
    },
    async get_promotion_list(req, res, next) {
        try {
            let filter = req.body
            let projection = {
                // _id: 0,
                name: 1,
                discount: 1,
            }
            const list = await PromotionService.get_promotion_list(
                filter,
                projection
            );
            if (!list) {
                return next(createError.BadRequest("Get list failed"));
            }
            if (list.length == 0) {
                return next(createError.NotFound("No promotion found"));
            }
            res.json({
                message: 'Get promotions list successfully',
                status: 200,
                data: list,
            })
        } catch (err) {
            next(createError.InternalServerError(err.message));
        }
    },
    async update_promotion(req, res, next) {
        try {
            const promotion_id = req.params.id
            const promotionInfo = req.body;
            // const { error, value } = update_promotion_schema.validate(req.body);
            // if (error) {
            //     return next(createError.BadRequest(error.details[0].message));
            // }
            // Update promotion
            const update_result = await PromotionService.update_promotion(promotion_id, promotionInfo);
            if (!update_result) {
                return res.status(404).json({
                    message: 'Promotion not found',
                    status: 404
                })
            }
            res.status(200).json({
                message: 'Update promotion successfully',
                status: 200,
                data: update_result,
            })
        } catch (err) {
            next(createError.InternalServerError(err.message));
        }
    },
    async delete_promotion(req,res,next){
        try {
            const promotion_id = req.params.id
            // Delete promotion
            const delete_result = await PromotionService.delete_promotion(promotion_id);
            if (!delete_result) {
                return res.status(404).json({
                    message: 'Promotion not found',
                    status: 404
                })
            }
            res.status(200).json({
                message: 'Delete promotion successfully',
                status: 200,
                data: delete_result,
            })
        } catch (err) {
            next(createError.InternalServerError(err.message));
        }
    }
};

export default PromotionController;
