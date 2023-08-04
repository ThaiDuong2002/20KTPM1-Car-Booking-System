import createError from "http-errors";

const authorization = (allowedRoles) => {
    return (req, res, next) => {
        const userRole = req.headers['x-user-role'] || null;
        if (userRole && allowedRoles.includes(userRole)) {
            next();
        } else {
            next(createError.Unauthorized("You are not authorized to access this page"));
        }
    };
};

export {
    authorization,
}