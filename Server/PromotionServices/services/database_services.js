import Promtion from '../models/Promotion.js'
import dotenv from 'dotenv';

dotenv.config();

const PromotionService = {
    async get_promotions_list(filter, projection) {
        return await Promtion.find(filter).select(projection);
    },
    async get_promotion_details(promotion_id) {
        return await Promtion.findById(promotion_id);
    },
    async create_promotion (promotion_data) {
        try {
            const promotion = new Promtion(promotion_data);
            await promotion.save();
            return promotion;
        } catch (err) {
            throw new Error(err.message);
        }
    },
    async update_promotion(promotion_id, update_fields) {
        try {
            return await Promtion.findByIdAndUpdate(
                promotion_id,
                update_fields,
                {new: true});
        } catch (err) {
            throw new Error(err.message);
        }
    },
    async delete_promotion(promotion_id) {
        try {
            return await Promtion.findByIdAndDelete(promotion_id)
        } catch (err) {
            throw new Error(err.message);
        }
    },
}

export {
    PromotionService,
}
