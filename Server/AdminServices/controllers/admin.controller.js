import createError from "http-errors";
import AdminServices from "../services/AdminServices.js";

const AdminController = {
    get_users: async (req, res, next) => {
        const filter = req.body

        const users = await AdminServices.getAllUsers(filter, '-password -refreshToken');
        if (!users) {
            return next(createError.BadRequest("users list not found"))

        }
        res.json({
            message: "Get users list successfully",
            status: 200,
            data: users
        })
    },
};

export default AdminController;
