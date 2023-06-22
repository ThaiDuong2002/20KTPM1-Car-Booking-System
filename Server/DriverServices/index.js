import cors from 'cors';
import dotenv from 'dotenv';
import express from 'express';
import db from './configs/db.js';
import { errorHandler, notFound } from './helper/errorHandler.js';
import routes from './routes/index.js';
import bodyParser from 'body-parser';

dotenv.config();

const app = express();

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

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
  console.log('Driver Services is running on port:' + process.env.PORT);
  console.log('http://localhost:' + process.env.PORT);
});
