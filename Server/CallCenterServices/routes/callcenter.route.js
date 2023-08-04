import express from 'express';
import CallcenterController from '../controllers/callcenter.controller.js';
import {authorization} from '../middlewares/authorization.js';

const router = express.Router();

router.get('/me', authorization(['consultant']), CallcenterController.me);
router.post('/me/edit', authorization(['consultant']), CallcenterController.edit_info);
router.post('/logout', authorization(['consultant']), CallcenterController.logout);

export default router;