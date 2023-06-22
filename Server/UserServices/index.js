import express from 'express';
import cors from "cors";
import dotenv from 'dotenv';
import { notFound, errorHandler } from './helper/errorHandler.js';
import db from './configs/db.js';


// import CustormerRoute from './routes/Customer.route.js';
import AdminRoute from './routes/Admin.route.js';
import ConsultantRoute from './routes/Consultant.route.js';
import DriverRoute from './routes/Driver.route.js';
import UserRoute from './routes/User.route.js';
dotenv.config();


const app = express();
var corsOptions = {
    origin: "http://localhost:" + process.env.PORT,
};
const initializeExpress = (app) => {
    app.use(cors(corsOptions));
    app.use(express.json());
    app.use(express.urlencoded({ extended: true }));
};
db();
initializeExpress(app);
app.use(UserRoute)
// app.use(CustormerRoute)
// app.use(AdminRoute);
// app.use(ConsultantRoute);
// app.use(DriverRoute)

app.use(notFound);
app.use(errorHandler);

app.listen(process.env.PORT, () => {
    console.log(" User Services is running on port:" + process.env.PORT);
    console.log("http://localhost:" + process.env.PORT);
});