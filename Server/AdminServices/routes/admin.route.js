import express from 'express';
import AdminController from '../controllers/admin.controller.js';
import {authorization} from '../middlewares/authorization.js';

const router = express.Router();

router.get('/getUsers', authorization(['admin']), AdminController.get_users);

export default router;