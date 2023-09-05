// import cors from 'cors';
// import dotenv from 'dotenv';
// import express from 'express';
// import db from './configs/db.js';
// import { errorHandler, notFound } from './helper/errorHandler.js';
// import routes from './routes/index.js';
// import bodyParser from 'body-parser';

// dotenv.config();

// const app = express();

// app.use(bodyParser.json());
// app.use(bodyParser.urlencoded({ extended: true }));

// const corsOptions = {
//   origin: 'http://localhost:' + process.env.PORT,
// };
// const initializeExpress = (app) => {
//   app.use(cors(corsOptions));
//   app.use(express.json());
//   app.use(express.urlencoded({ extended: true }));
// };

// initializeExpress(app);

// routes(app);
// db();

// app.use(notFound);
// app.use(errorHandler);

// app.listen(process.env.PORT, () => {
//   console.log('Driver Services is running on port:' + process.env.PORT);
//   console.log('http://localhost:' + process.env.PORT);
// });
// Server side implementation

// Server side implementation
// import express from 'express';
// import db from './configs/db.js';
// import { errorHandler, notFound } from './helper/errorHandler.js';
// import driverRoute from './routes/driverRoute.js';
// import bodyParser from 'body-parser';
//
// dotenv.config();
//
// const app = express();
// const server = http.createServer(app);
// const io = new Server(server);
//
// server.listen(3004, () => console.log('Server started on port 3004'));
//
// io.on('connection', (socket) => {
//   console.log('User connected');
//
// initializeExpress(app);
// db();
//
// app.use(driverRoute);
// app.use(notFound);
// app.use(errorHandler);
//
// app.listen(process.env.PORT, () => {
//   console.log('Driver Services is running on port:' + process.env.PORT);
//   console.log('http://localhost:' + process.env.PORT);
// });

import cors from 'cors';
import dotenv from 'dotenv';
import express from 'express';
import {initializeApp, redis, mongoose_conn} from './configs/db.js';
import { errorHandler, notFound } from './helper/errorHandler.js';
import DriverRoute from './routes/driverRoute.js';
import VehicleRoute from './routes/vehicleRoute.js';

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
await initializeApp();

// Set up a SIGINT (Ctrl+C) signal handler to gracefully disconnect from Redis
process.on('SIGINT', async () => {
  try {
    await redis.quit();
    console.log('\nDisconnected from Redis.');
    process.exit(0);
  } catch (err) {
    console.error('Error while closing connections:', err);
    process.exit(1); // Exit with an error code
  }
});

initializeExpress(app);
app.use(DriverRoute)
app.use(VehicleRoute)
app.use(notFound);
app.use(errorHandler);

app.listen(process.env.PORT, () => {
  console.log('Driver Services is running on port:' + process.env.PORT);
  console.log('http://localhost:' + process.env.PORT);
});
