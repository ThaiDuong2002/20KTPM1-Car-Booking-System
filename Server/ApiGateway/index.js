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
const initializeExpress = (app) => {
  app.use(cors(corsOptions));
  app.use(express.json());
  app.use(express.urlencoded({ extended: true }));
};

initializeExpress(app);

const routes = {
  '/api/admin': 'http://localhost:3001',
  '/api/callcenter': 'http://localhost:3002',
  '/api/customer': 'http://localhost:3003',
  '/api/driver': 'http://localhost:3004',
};

for (const route in routes) {
  app.use(
    route,
    createProxyMiddleware({
      target: routes[route],
      changeOrigin: true,
      pathRewrite: {
        [`^${route}`]: '',
      },
    })
  );
}

app.get('/', (req, res) => {
  res.send('Hello from API Gateway');
});

app.use(notFound);
app.use(errorHandler);

app.listen(process.env.PORT, () => {
  console.log('API Gateway is running on port:' + process.env.PORT);
  console.log('http://localhost:' + process.env.PORT);
});
