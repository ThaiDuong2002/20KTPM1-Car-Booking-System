import {Price} from '../models/PriceModel.js'
import {Promotion} from '../models/PromotionModel.js'
import dotenv from 'dotenv';

dotenv.config();

const baseFare = parseInt(process.env.BASE_FARE);

const noonTimeFare = parseInt(process.env.NOON_TIME_FARE);
const eveningTimeFare = parseInt(process.env.EVENING_TIME_FARE);
const nightTimeFare = parseInt(process.env.NIGHT_TIME_FARE);

const carTypeFare = parseInt(process.env.CAR_TYPE_FARE);
const bikeTypeFare = parseInt(process.env.BIKE_TYPE_FARE);

const PriceService = {
    async get_price_list(filter, projection) {
        return await Price.find(filter).select(projection);
    },
    async get_price_details(price_id) {
        return await Price.findById(price_id);
    },
    async create_price (price_data) {
        try {
            const price = new Price(price_data);
            return await price.save();
        } catch (err) {
            throw new Error(err.message);
        }
    },
    async get_calculate_fee(distance, time, tripType) {
        let totalFare = distance * baseFare;
        const timestamp = Date.parse(time);
        const dateObject = new Date(timestamp);
        // Get the hour component
        const hours = dateObject.getHours();
        console.log(hours)
        // Noon time: 11h - 14h
        if (hours >= 11 && hours < 14) {
            console.log("Noon time")
            totalFare += noonTimeFare;
        }
        // Evening time: 17h - 19h
        if (hours >= 17 && hours < 19) {
            console.log("Evening time")
            totalFare += eveningTimeFare;
        }
        // Night time: 22h - 6h
        if (hours >= 22 || hours < 6) {
            console.log("Night time")
            totalFare += nightTimeFare;
        }
        // Trip type
        if (tripType === "car") {
            console.log("Car type")
            totalFare += carTypeFare;
        }
        if (tripType === "bike") {
            console.log("Bike type")
            totalFare += bikeTypeFare;
        }
        console.log(totalFare)
        return totalFare
    },
}

export {
    PriceService,
}
