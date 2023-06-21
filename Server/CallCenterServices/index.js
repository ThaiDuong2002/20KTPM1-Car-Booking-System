import cors from 'cors';
import dotenv from 'dotenv';
import express from 'express';
import db from './configs/db.js';
import { errorHandler, notFound } from './helper/errorHandler.js';
import routes from './routes/index.js';

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

routes(app);

db();

app.use(notFound);
app.use(errorHandler);

app.listen(process.env.PORT, () => {
  console.log('CallCenter Services is running on port:' + process.env.PORT);
  console.log('http://localhost:' + process.env.PORT);
});
