import express from 'express';
import CallcenterController from '../controllers/callcenter.controller.js';

const router = express.Router();

router.get('/', CallcenterController.test);

export default router;