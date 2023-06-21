import express from 'express';
import TestController from '../controllers/test.controller.js';

const router = express.Router();

router.get('/', TestController.test);

export default router;