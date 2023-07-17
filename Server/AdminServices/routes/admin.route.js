import express from 'express';
import AdminController from '../controllers/admin.controller.js';
import Authorization from '../middlewares/authorization.js';

const router = express.Router();

router.get('/getAdmins', Authorization.isAdmin, AdminController.get_admins);
router.get('/getUsers', Authorization.isAdmin, AdminController.get_users);

export default router;