import createError from "http-errors";
import AdminServices from "../services/database_services.js";

const AdminController = {
    get_admins: async (req, res, next) => {
        const filter = req.body
        console.log("filter", filter)
        const admins = await AdminServices.getAllUsers({
            "__t": "Admin",
            ...filter
        }, '-_id firstname lastname email phone avatar');
        if (!admins) {
            return next(createError.BadRequest("admins list not found"))
        }
        res.json({
            message: "Get admins list successfully",
            status: 200,
            data: admins
        })
    },
    get_users: async (req, res, next) => {
        let req_filter = req.body
        let filter = {
            __t: {
                $ne: "Admin"
            },
            ...req_filter,
        }

        const users = await AdminServices.getAllUsers(filter, '-_id firstname lastname email phone avatar');
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
