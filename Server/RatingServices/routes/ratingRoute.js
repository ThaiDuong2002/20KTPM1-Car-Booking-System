import express from 'express';
import RatingController from '../controllers/ratingController.js';
const router = express.Router();

router.get('/', RatingController.getAllRatings);
router.get('/:driverId', RatingController.getdriverRatings);
router.post('/', RatingController.addRating);
router.put('/:id', RatingController.updateRating);
router.delete('/:id', RatingController.deleteRating);

export default router;