import express from 'express';
import CallcenterController from '../controllers/callcenter.controller.js';

const router = express.Router();

router.get('/me', CallcenterController.me);
router.post('/me/edit', CallcenterController.edit_info);
router.post('/logout', CallcenterController.logout);


export default router;