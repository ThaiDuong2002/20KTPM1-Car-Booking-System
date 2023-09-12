import cors from 'cors';
import dotenv from 'dotenv';
import express from 'express';
import db from './configs/db.js';
import { errorHandler, notFound } from './helper/errorHandler.js';
import PriceRoute from './routes/priceRoute.js';
import PaymentMethodRoute from './routes/paymentMethodRoute.js';
import RuleRoute from './routes/ruleRoute.js';

dotenv.config();

const app = express();
const corsOptions = {
    origin: 'http://localhost:' + process.env.PORT,
};
const initializeExpress = (app) => {
    app.use(cors(corsOptions));
    app.use(express.json());
    app.use(express.urlencoded({ extended: true }));
};
db();
initializeExpress(app);
app.use("/payment_method", PaymentMethodRoute)
app.use("/rules", RuleRoute)
app.use(PriceRoute)
app.use(notFound);
app.use(errorHandler);

app.listen(process.env.PORT, () => {
    console.log('Price Services is running on port:' + process.env.PORT);
    console.log('http://localhost:' + process.env.PORT);
});
