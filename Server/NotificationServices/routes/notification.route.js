import express from 'express';
import NotificationController from '../controllers/notification.controller.js';
const router = express.Router();

router.get('/', NotificationController.get_notification_list);
router.get('/:id', NotificationController.get_notification_details);
router.post('/', NotificationController.add_notification);
router.put('/:id', NotificationController.update_notification);
router.delete('/:id', NotificationController.delete_notification);

export default router;