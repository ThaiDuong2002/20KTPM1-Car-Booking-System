import {Promotion} from '../models/PromotionModel.js'

const PromotionService = {
    async get_promotion_list(filter, projection) {
        return await Promotion.find(filter).select(projection);
    },
    async get_promotion_details(promotion_id) {
        return await Promotion.findById(promotion_id);
    },
    async create_promotion (promotion_data) {
        try {
            const promotion = new Promotion(promotion_data);
            return await promotion.save();
        } catch (err) {
            throw err;
        }
    },
    async update_promotion(promotion_id, update_fields) {
        try {
            return await Promotion.findByIdAndUpdate(
                promotion_id,
                update_fields,
                {new: true});
        } catch (err) {
            throw err;
        }
    },
    async delete_promotion(promotion_id) {
        try {
            return await Promotion.findByIdAndDelete(promotion_id)
        } catch (err) {
            throw err;
        }
    },
}

export {
    PromotionService,
}
