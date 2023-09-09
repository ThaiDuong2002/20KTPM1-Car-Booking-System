import createError from 'http-errors'
import {UserService, RatingService} from '../services/services.js';

const RatingController = {
    getAllRatings: async (req, res, next) => {
        try {
            const filter = req.body;
            const ratings = await RatingService.getAllRatings(filter, {});
            if (!ratings) {
                return next(createError.NotFound(404, 'Ratings list not found'));
            }
            res.status(200).json({
                message: "Get all ratings successfully",
                status: 200,
                data: ratings
            });
        } catch (err) {
            next(createError.InternalServerError(err.message));
        }
    },
    getdriverRatings: async (req, res, next) => {
        try {
            const driverId = req.params.driverId;
            const driver = await UserService.getUserById(driverId, '-_id -password -refreshToken');
            if (!driver) {
                return next(createError.NotFound(404, 'Driver not found'));
            }
            const ratings = await RatingService.getdriverRatings(driverId);
            if (!ratings) {
                return next(createError.NotFound(404, 'Ratings list not found'));
            }
            res.status(200).json({
                message: "Get driver ratings successfully",
                status: 200,
                data: ratings
            });
        } catch (err) {
            next(createError.InternalServerError(err.message));
        }
    },
    addRating: async (req, res, next) => {
        try {
            const ratingInfo = req.body;
            const rating = await RatingService.createRating(ratingInfo);
            if (!rating) {
                return next(createError.NotFound(404, 'Add rating failed'));
            }
            res.status(201).json({
                message: "Add rating successfully",
                status: 201,
                data: rating
            });
        } catch (err) {
            next(createError.InternalServerError(err.message));
        }
    },
    updateRating: async (req, res, next) => {
        try {
            const ratingId = req.params.id;
            const updateInfo = req.body;
            const rating = await RatingService.updateRating(ratingId, updateInfo);
            if (!rating) {
                return next(createError.NotFound(404, 'Update rating failed'));
            }
            res.status(200).json({
                message: "Update rating successfully",
                status: 200,
                data: rating
            });
        } catch (err) {
            next(createError.InternalServerError(err.message));
        }
    },
    deleteRating: async (req, res, next) => {
        try {
            const ratingId = req.params.id;
            const rating = await RatingService.deleteRating(ratingId);
            if (!rating) {
                return next(createError.NotFound(404, 'Delete rating failed'));
            }
            res.status(200).json({
                message: "Delete rating successfully",
                status: 200,
                data: rating
            });
        } catch (err) {
            next(createError.InternalServerError(err.message));
        }
    },
};

export default RatingController;
