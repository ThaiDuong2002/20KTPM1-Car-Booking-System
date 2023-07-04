import express from 'express';
import CallcenterController from '../controllers/callcenter.controller.js';

const router = express.Router();

router.get('/', CallcenterController.test);
// router.get('/me', CallcenterController.me);
router.get('/logout', CallcenterController.logout);


export default router;