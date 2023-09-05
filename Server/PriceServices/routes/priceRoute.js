import express from 'express';
import PriceController from '../controllers/priceController.js';
const router = express.Router();

router.get('/', PriceController.get_price_list);
router.get('/fee', PriceController.calculate_fee);
router.get('/:id', PriceController.get_price_details);
router.post('/', PriceController.create_price);

export default router;