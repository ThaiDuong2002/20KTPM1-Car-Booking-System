import cors from 'cors';
import dotenv from 'dotenv';
import express from 'express';
import { errorHandler, notFound } from './helper/errorHandler.js';
import adminRoute from './routes/admin.route.js';
import db from './configs/db.js';

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

initializeExpress(app);
db();

app.use(adminRoute);
app.use(notFound);
app.use(errorHandler);

app.listen(process.env.PORT, () => {
  console.log('Admin Services is running on port: ' + process.env.PORT);
  console.log('http://localhost:' + process.env.PORT);
});
