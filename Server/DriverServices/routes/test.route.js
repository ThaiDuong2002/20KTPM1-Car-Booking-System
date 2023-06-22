import express from 'express';
import TestController from '../controllers/test.controller.js';

const router = express.Router();

router.get('/test', TestController.test);
router.post('/create', TestController.create);

export default router;