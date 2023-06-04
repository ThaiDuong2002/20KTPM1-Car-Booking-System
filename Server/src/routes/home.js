import express from 'express';
import homeController from '../app/controllers/HomeController.js';

const router = express.Router();

router.use('/', homeController.index);

export default router;
