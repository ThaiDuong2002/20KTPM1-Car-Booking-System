import bodyParser from 'body-parser';
import cookieParser from 'cookie-parser';
import * as dotenv from 'dotenv';
import express from 'express';
import db from './config/db/index.js';
import route from './routes/index.js';
import morgan from 'morgan';

const app = express();
const port = 3000;
dotenv.config();
db.connect();

app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());

app.use(express.json());
app.use(cookieParser());
app.use(morgan('combined'));

route(app);

app.listen(port, () =>
  console.log(`App listening at http://localhost:${port}`)
);
