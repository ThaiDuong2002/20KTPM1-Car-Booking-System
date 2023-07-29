import Notification from '../models/Notification.js'
import dotenv from 'dotenv';
import axios from "axios";

dotenv.config();

const NotificationService = {
    async get_notification_list(filter, projection) {
        return await Notification.find(filter).select(projection);
    },
    async get_notification_details(notification_id) {
        return await Notification.findById(notification_id);
    },
    async create_notification (notification_data) {
        try {
            const notification = new Notification(notification_data);
            await notification.save();
            return notification;
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
    async valid_user(user_id){
        const service_uri = `${process.env.AUTHEN_SERVICE_URI}/info/${user_id}`
        const response = await axios.get(service_uri)
        return response.data.data
    }
}

export {
    NotificationService,
    UserService
}
