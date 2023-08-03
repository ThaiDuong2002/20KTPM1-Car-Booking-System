import express from 'express';
import cors from "cors";
import dotenv from 'dotenv';
import {notFound, errorHandler} from './helper/errorHandler.js';
import db from './configs/db.js';
import bookRouter from './routes/booking.route.js';
import placeRouter from './routes/place.route.js';

dotenv.config();

const app = express();
var corsOptions = {
    origin: "http://localhost:" + process.env.PORT,
};
const initializeExpress = (app) => {
    app.use(cors(corsOptions));
    app.use(express.json());
    app.use(express.urlencoded({extended: true}));
};
db();
initializeExpress(app);
app.use('/book', bookRouter)
app.use('/place', placeRouter)
app.use(errorHandler);
app.use(notFound);

app.listen(process.env.PORT, () => {
    console.log("Booking Services is running on port:" + process.env.PORT);
    console.log("http://localhost:" + process.env.PORT);
});