import express from 'express';
import CallcenterController from '../controllers/callcenter.controller.js';
import Authorization from '../middlewares/authorization.js';
const router = express.Router();

router.get('/me', Authorization.isConsultant, CallcenterController.me);
router.post('/me/edit', Authorization.isConsultant, CallcenterController.edit_info);
router.post('/logout', Authorization.isConsultant, CallcenterController.logout);
router.post('/booking', Authorization.isConsultant, CallcenterController.booking);

export default router;