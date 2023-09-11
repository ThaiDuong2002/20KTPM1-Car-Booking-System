import express from 'express';
import PaymentMethodController from '../controllers/paymentMethodController.js';
const router = express.Router();

router.get('', PaymentMethodController.get_payment_method_list);
router.get('/:id', PaymentMethodController.get_payment_method_details);

router.post('/', PaymentMethodController.create_payment_method);
router.put('/:id', PaymentMethodController.update_payment_method);
router.delete('/:id', PaymentMethodController.delete_payment_method);

export default router;