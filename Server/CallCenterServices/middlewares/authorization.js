import createError from "http-errors";
const Authorization = {
    async isAdmin(req, res, next) {
        const role = req.headers['x-user-role'] || null;
        if (role != null) {
            if (role == "Admin") {
                next();
            } else {
                next(createError.Unauthorized("You are not authorized to access this page"));
            }
        }
    },
    async isConsultant(req, res, next) {
        const role = req.headers['x-user-role'] || null;
        console.log("role", role)
        if (role != null) {
            if (role == "Consultant") {
                next();
            } else {
                next(createError.Unauthorized("You are not authorized to access this page"));
            }
        }
    },
    async isDriver(req, res, next) {
        const role = req.headers['x-user-role'] || null;
        if (role != null) {
            if (role == "Driver") {
                next();
            } else {
                next(createError.Unauthorized("You are not authorized to access this page"));
            }
        }
    },
    async isCustomer(req, res, next) {
        const role = req.headers['x-user-role'] || null;
        if (role != null) {
            if (role == "Customer") {
                next();
            } else {
                next(createError.Unauthorized("You are not authorized to access this page"));
            }
        }
    },
}

export default Authorization;