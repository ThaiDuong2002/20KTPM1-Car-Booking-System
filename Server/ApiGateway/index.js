import cors from 'cors';
import dotenv from 'dotenv';
import express from 'express';
import { createProxyMiddleware } from 'http-proxy-middleware';
import TokenService from './middlewares/jwt_services.js';
import { errorHandler, notFound } from './helper/errorHandler.js';

dotenv.config();
const app = express();


const corsOptions = {
    origin: 'http://localhost:' + process.env.PORT,
};

// const routes = {
//     '/api/authen': `http://localhost:${process.env.PORT_AUTHEN}`,
//     '/api/admin': `http://localhost:${process.env.PORT_ADMIN}`,
//     '/api/callcenter': `http://localhost:${process.env.PORT_CALLCENTER}`,
//     '/api/customer': `http://localhost:${process.env.PORT_CUSTOMER}`,
//     '/api/driver': `http://localhost:${process.env.PORT_DRIVER}`,
//     '/api/bookings': `http://localhost:${process.env.PORT_BOOKING}`,
//     '/api/ratings': `http://localhost:${process.env.PORT_RATING}`,
//     '/api/promotions': `http://localhost:${process.env.PORT_PROMOTION}`,
//     '/api/notifications': `http://localhost:${process.env.PORT_NOTIFICATION}`,
//     '/api/prices': `http://localhost:${process.env.PORT_PRICE}`,
// };

const routes = {
    '/api/authen': `http://authen-services:${process.env.PORT_AUTHEN}`,
    '/api/admin': `http://admin-services:${process.env.PORT_ADMIN}`,
    '/api/callcenter': `http://callcenter-services:${process.env.PORT_CALLCENTER}`,
    '/api/customer': `http://customer-services:${process.env.PORT_CUSTOMER}`,
    '/api/driver': `http://driver-services:${process.env.PORT_DRIVER}`,
    '/api/bookings': `http://booking-services:${process.env.PORT_BOOKING}`,
    '/api/ratings': `http://rating-services:${process.env.PORT_RATING}`,
    '/api/promotions': `http://promotion-services:${process.env.PORT_PROMOTION}`,
    '/api/notifications': `http://notification-services:${process.env.PORT_NOTIFICATION}`,
    '/api/prices': `http://price-services:${process.env.PORT_PRICE}`,
};

const unless = (path, middleware) => {
    return function (req, res, next) {
        if (req.path.includes(path)) {
            return next();
        } else {
            return middleware(req, res, next);
        }
    };
};

// app.use((unless('/api/authen', TokenService.verifyAccessToken)));    
for (const route in routes) {
    app.use(
        route,
        //
        createProxyMiddleware({
            target: routes[route],
            changeOrigin: true,
            logLevel: 'debug',
            pathRewrite: {
                [`^${route}`]: '',
            },
        })
        ///
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

app.use(errorHandler);
app.use(notFound);

app.listen(process.env.PORT, () => {
    console.log('API Gateway is running on port:' + process.env.PORT);
    console.log('http://localhost:' + process.env.PORT);
});

