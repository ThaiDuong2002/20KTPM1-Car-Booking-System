import express from 'express';
import placeController from '../controllers/place.controller.js';

const router = express.Router();

router.get('/queryautocomplete', placeController.get_query_place_list);
router.get('/textsearch', placeController.get_text_search_place_list);

export default router;
