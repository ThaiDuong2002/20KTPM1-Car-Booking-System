import express from 'express';
import cors from "cors";
import dotenv from 'dotenv';
import { notFound, errorHandler } from './helper/errorHandler.js';
import { createProxyMiddleware } from 'http-proxy-middleware';
dotenv.config();


const app = express();
var corsOptions = {
    origin: "http://localhost:" + process.env.PORT,
};
const initializeExpress = (app) => {
    app.use(cors(corsOptions));
    app.use(express.json());
    app.use(express.urlencoded({ extended: true }));
};

initializeExpress(app);

app.get('/', (req, res) => {
    res.send("Hello from Ratings Services");
});

app.use(notFound);
app.use(errorHandler);

app.listen(process.env.PORT, () => {
    console.log("Ratings Services is running on port:" + process.env.PORT);
    console.log("http://localhost:" + process.env.PORT);
});