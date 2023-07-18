import createError from "http-errors";
import AdminServices from "../services/database_services.js";

const AdminController = {
    get_users: async (req, res, next) => {
        const filter = req.body
        console.log(filter)

        const users = await AdminServices.getAllUsers(filter, '-_id firstname lastname email phone avatar role');
        if (!users) {
            return next(createError.BadRequest("users list not found"))

        }
        console.log(users)
        res.json({
            message: "Get users list successfully",
            status: 200,
            data: users
        })
    },
};

export default AdminController;
