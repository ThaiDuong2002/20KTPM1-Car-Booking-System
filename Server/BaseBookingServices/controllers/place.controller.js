import createError from 'http-errors';
import axios from "axios";
import {MapService} from '../services/services.js';
import dotenv from "dotenv";

dotenv.config();

const placeController = {
    async get_query_place_list(req, res, next) {
        const {input, location} = req.query
        try {
            const list_place = await MapService.get_query_places(input, location)
            res.json({
                message: "Get query place list successfully",
                status: 200,
                data: list_place
            })
        } catch (err) {
            next(createError.InternalServerError(err.message));
        }
    },
    async get_text_search_place_list(req, res, next) {
        const {query, location} = req.query
        console.log(query, location)
        try {
            const list_place = await MapService.get_text_search_places(query, location)
            res.json({
                message: "Get text search place list successfully",
                status: 200,
                data: list_place
            })
        } catch (err) {
            next(createError.InternalServerError(err.message));
        }
    },
}

export default placeController;