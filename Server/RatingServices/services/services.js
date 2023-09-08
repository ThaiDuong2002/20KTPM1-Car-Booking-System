import {Rating} from '../models/RatingModel.js'
import {User} from '../models/UserModel.js'

const RatingService = {
    getAllRatings: async (filter, projection) => {
        try {
            const ratings = await Rating.find(filter).select(projection);
            return ratings;
        } catch (err) {
            throw err;
        }
    },
    getdriverRatings: async (driverId, projection) => {
        try {
            const ratings = await Rating.find({driverId: driverId}).select(projection);
            return ratings;
        } catch (err) {
            throw err;
        }
    },
    createRating: async (ratingInfo) => {
        try {
            const rating = new Rating(ratingInfo);
            return await rating.save();
        } catch (err) {
            throw err;
        }
    },
    updateRating: async (ratingId, updateInfo) => {
        try {
            const updatedRating = await Rating.findByIdAndUpdate(ratingId, updateInfo, {new: true});
            return updatedRating;
        } catch (err) {
            throw err;
        }
    },
    deleteRating: async (ratingId) => {
        try {
            const deletedRating = await Rating.findByIdAndDelete(ratingId);
            return deletedRating;
        } catch (err) {
            throw err;
        }
    },
}

export {
    RatingService,
}
