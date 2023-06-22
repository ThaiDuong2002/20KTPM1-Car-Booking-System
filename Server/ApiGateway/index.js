import bodyParser from 'body-parser';
import cors from 'cors';
import dotenv from 'dotenv';
import express from 'express';
import { createProxyMiddleware } from 'http-proxy-middleware';
import { errorHandler, notFound } from './helper/errorHandler.js';

dotenv.config();

const app = express();

const corsOptions = {
  origin: 'http://localhost:' + process.env.PORT,
};

const routes = {
  '/api/admin': `http://localhost:${process.env.PORT_ADMIN}`,
  '/api/callcenter': `http://localhost:${process.env.PORT_CALLCENTER}`,
  '/api/customer': `http://localhost:${process.env.PORT_CUSTOMER}`,
  '/api/driver': `http://localhost:${process.env.PORT_DRIVER}`,
};

for (const route in routes) {
  app.use(
    route,
    createProxyMiddleware({
      target: routes[route],
      changeOrigin: false,
      logLevel: 'debug',
      pathRewrite: {
        [`^${route}`]: '',
      },
    })
  );
}

const initializeExpress = (app) => {
  app.use(cors(corsOptions));
  app.use(express.json());
  app.use(express.urlencoded({ extended: true }));
};

initializeExpress(app);

app.get('/', (req, res) => {
  res.send('Hello from API Gateway');
});

app.use(notFound);
app.use(errorHandler);

app.listen(process.env.PORT, () => {
  console.log('API Gateway is running on port:' + process.env.PORT);
  console.log('http://localhost:' + process.env.PORT);
});
