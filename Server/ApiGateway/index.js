import express from 'express';
import cors from "cors";
import dotenv from 'dotenv';
import { notFound, errorHandler } from './helper/errorHandler.js';
import { createProxyMiddleware } from 'http-proxy-middleware';
import TokenService from './middlewares/jwt_services.js';
dotenv.config();
const app = express();
var corsOptions = {
    origin: "http://localhost:" + process.env.PORT,
};
const routes = {
    '/api/users': 'http://localhost:3001',
    '/api/bookings': 'http://localhost:3002',
    '/api/ratings': 'http://localhost:3003',
    '/api/promotions': 'http://localhost:3004',
}
const initializeExpress = (app) => {
    app.use(cors(corsOptions));
    app.use(express.json());
    app.use(express.urlencoded({ extended: true }));
    app.use(TokenService.verifyToken);
};
initializeExpress(app);

for (const route in routes) {
    app.use(route,  createProxyMiddleware({
        target: routes[route],
        changeOrigin: true,
        logLevel: 'debug',
        pathRewrite: {
            [`^${route}`]: '',
        },
    }));
}

app.get('/', (req, res) => {
    res.send("Hello from API Gateway");
});

app.use(notFound);
app.use(errorHandler);

app.listen(process.env.PORT, () => {
    console.log("API Gateway is running on port:" + process.env.PORT);
    console.log("http://localhost:" + process.env.PORT);
});