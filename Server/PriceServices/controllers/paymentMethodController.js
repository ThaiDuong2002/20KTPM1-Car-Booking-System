import createError from 'http-errors'
import {PaymentService} from '../services/services.js';

const PaymentMethodController = {
    async get_payment_method_list(req, res, next) {
        try {
            let filter = req.body
            const list = await PaymentService.getPaymentMethodList(filter, "");
            if (!list) {
                return next(createError.BadRequest("Get list failed"));
            }
            if(list.length === 0) {
                return next(createError.NotFound("No Payment Method found"));
            }
            res.json({
                message: 'Get payment methods list successfully',
                status: 200,
                data: list,
            })
        } catch (err) {
            next(createError.InternalServerError(err.message));
        }
    },
    async get_payment_method_details(req, res, next) {
        try {
            const paymentMethodId = req.params.id
            const paymentMethod = await PaymentService.getPaymentMethodDetails(paymentMethodId);
            if (!paymentMethod) {
                return next(createError.NotFound("Payment Method not found"));
            }
            res.json({
                message: 'Get payment method details successfully',
                status: 200,
                data: paymentMethod,
            })
        } catch (err) {
            next(createError.InternalServerError(err.message));
        }
    },
    async create_payment_method(req, res, next) {
        try {
            const paymentMethodInfo = req.body;
            // Create payment method
            const paymentMethod_re = await PaymentService.createPaymentMethod(paymentMethodInfo);
            res.status(201).json({
                message: 'Create payment method successfully',
                status: 200,
                data: paymentMethod_re,
            })
        } catch (err) {
            next(createError.InternalServerError(err.message));
        }
    },
    async update_payment_method(req, res, next) {
        try {
            const paymentMethodId = req.params.id;
            const updateInfo = req.body;
            // Update payment method
            const paymentMethod_re = await PaymentService.updatePaymentMethod(paymentMethodId, updateInfo);
            res.status(200).json({
                message: 'Update payment method successfully',
                status: 200,
                data: paymentMethod_re,
            })
        } catch (err) {
            next(createError.InternalServerError(err.message));
        }
    },
    async delete_payment_method(req, res, next) {
        try {
            const paymentMethodId = req.params.id;
            // Delete payment method
            const paymentMethod_re = await PaymentService.deletePaymentMethod(paymentMethodId);
            res.status(200).json({
                message: 'Delete payment method successfully',
                status: 200,
                data: paymentMethod_re,
            })
        } catch (err) {
            next(createError.InternalServerError(err.message));
        }
    },
};

export default PaymentMethodController;
