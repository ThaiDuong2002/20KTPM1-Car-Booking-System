import cors from "cors";
import dotenv from "dotenv";
import express from "express";
import db from "./configs/db.js";
import { errorHandler, notFound } from "./helper/errorHandler.js";
import NotificationRoute from "./routes/notification.route.js";

dotenv.config();

const app = express();
const corsOptions = {
  origin: ["http://localhost:4001", "http://localhost:4002"],
};
const initializeExpress = (app) => {
  app.use(cors(corsOptions));
  app.use(express.json());
  app.use(express.urlencoded({ extended: true }));
};
db();
initializeExpress(app);
app.use(NotificationRoute);
app.use(notFound);
app.use(errorHandler);

app.listen(process.env.PORT, () => {
  console.log("Notification Services is running on port:" + process.env.PORT);
  console.log("http://localhost:" + process.env.PORT);
});
