import express from "express";
import cors from "cors";
import dotenv from "dotenv";
import { notFound, errorHandler } from "./helper/errorHandler.js";
import db from "./configs/db.js";
import preBookingRouter from "./routes/preBooking.route.js";
import bookingRouter from "./routes/booking.route.js";
import placeRouter from "./routes/place.route.js";

dotenv.config();

const app = express();
var corsOptions = {
  origin: "http://localhost:" + process.env.CLIENT_PORT,
};
const initializeExpress = (app) => {
  app.use(cors(corsOptions));
  app.use(express.json());
  app.use(express.urlencoded({ extended: true }));
};
db();
initializeExpress(app);
app.use("/pre_booking", preBookingRouter);
app.use("/booking", bookingRouter);
app.use("/place", placeRouter);
app.use(errorHandler);
app.use(notFound);

app.listen(process.env.PORT, () => {
  console.log("Booking Services is running on port:" + process.env.PORT);
  console.log("http://localhost:" + process.env.PORT);
});
