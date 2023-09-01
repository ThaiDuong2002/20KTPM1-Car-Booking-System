import Notification from '../models/NotificationModel.js'
import {User} from '../models/UserModel.js'
import dotenv from 'dotenv';

dotenv.config();

const NotificationService = {
    async get_notification_list(filter, projection) {
        const result = await Notification.find(filter).select(projection);
        return result;
    },
    async get_notification_details(notification_id) {
        const result = await Notification.findById(notification_id);
        return result
    },
    async create_notification (notification_data) {
        try {
            const newNotification = new Notification(notification_data);
            return await newNotification.save();
        } catch (err) {
            throw new Error(err.message);
        }
    },
    async update_notification(notification_id, update_fields) {
        try {
            return await Notification.findByIdAndUpdate(
                notification_id,
                update_fields,
                {new: true});
        } catch (err) {
            throw new Error(err.message);
        }
    },
    async delete_notification(notification_id) {
        try {
            return await Notification.findByIdAndDelete(notification_id)
        } catch (err) {
            throw new Error(err.message);
        }
    },
}

const UserService = {
    async getUserById(user_id, filter, projection) {
        const result = await User.findOne({
                _id: user_id,
                ...filter
            }
        ).select(projection)
        return result
    },
}

export {
    NotificationService,
    UserService
}
