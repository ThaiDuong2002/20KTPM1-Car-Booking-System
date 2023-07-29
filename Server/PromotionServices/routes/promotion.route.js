import express from 'express';
import PromotionController from '../controllers/promotion.controller.js';
const router = express.Router();

router.get('/', PromotionController.get_promotion_list);
router.get('/:id', PromotionController.get_promotion_details);
router.post('/', PromotionController.add_promotion);
router.put('/:id', PromotionController.update_promotion);
router.delete('/:id', PromotionController.delete_promotion);

export default router;