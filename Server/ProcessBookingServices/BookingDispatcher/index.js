import express from 'express';
import process from "process";
import dotenv from 'dotenv';
import amqp from "amqplib";
import http from "http";
import axios from 'axios';
import { Server } from "socket.io";

import db from './configs/db.js';
import SocketListener from './utils/socket.js';
import GoongService from "./services/goongService.js";

dotenv.config();

const app = express();
const config = process.env;

const server = http.createServer(app);
const io = new Server(server);
const goongService = new GoongService();

global.userActive = {};
app.use((req, res, next) => {
    req.io = io;
    next();
});


// Dùng body-parser (nếu bạn sử dụng Express < 4.16.0)
app.use(express.json());
app.use(express.urlencoded({ extended: true }));
let channel = null;

async function dispatcher() {
    try {
        const connection = await amqp.connect(config.AMQP_URL);
        channel = await connection.createChannel();
        const exchangeName = config.EXCHANGE_NAME;
        const queueName = config.QUEUE_NAME;
        const routingKey = config.DISPATCHER_ROUTING_KEY;
        await channel.assertExchange(exchangeName, 'direct', { durable: false });
        const assertQueueResponse = await channel.assertQueue(queueName);
        const queue = assertQueueResponse.queue;
        await channel.bindQueue(queue, exchangeName, routingKey);
        console.log(`[*] Booking reception.`);
        console.log(`[*] Waiting for booking info.`);



        // Consume message
        await channel.consume(queue, async (msg) => {
            try {
                const bookingInfo = JSON.parse(msg.content.toString());
                console.log(`[x] Received booking info:`, bookingInfo);

                // const pickupLocationCoordination = bookingInfo.trip_pickup_location.coordinate;
                // const tripType = bookingInfo.trip_type;

                // // Get drivers location (db or redis)
                // const drivers_location = [
                //     {id: 1, latitude: 10.772580, longitude: 106.698028, type: "bike"},
                //     {id: 2, latitude: 10.779783, longitude: 106.698930, type: "bike"},
                //     {id: 3, latitude: 10.776056, longitude: 106.700854, type: "car"},
                //     {id: 4, latitude: 10.779400, longitude: 106.699296, type: "bike"},
                //     {id: 5, latitude: 10.771986, longitude: 106.704874, type: "car"},
                //     {id: 6, latitude: 10.768097, longitude: 106.692112, type: "bike"},
                //     {id: 7, latitude: 10.773104, longitude: 106.706250, type: "car"},
                //     {id: 8, latitude: 10.786040, longitude: 106.705215, type: "bike"},
                //     {id: 9, latitude: 10.772580, longitude: 106.698028, type: "car"},
                //     {id: 10, latitude: 10.776554, longitude: 106.700916, type: "bike"},
                // ];

                // const drivers_distance_list = await goongService.getDriverDistanceList(
                //     pickupLocationCoordination.x,
                //     pickupLocationCoordination.y,
                //     tripType,
                //     drivers_location
                // )
                // console.log(drivers_distance_list);

                // // Send booking info to the driver
                // const driverId = drivers_distance_list[0].id;
                // const driverExchangeName = 'driver_exchange';
                // const driverRoutingKey = `driver.${driverId}`;
                // await channel.assertExchange(driverExchangeName, 'direct', { durable: false });
                // await channel.assertExchange(driverExchangeName, 'direct', {durable: false});
                // await channel.publish(driverExchangeName, driverRoutingKey, Buffer.from(JSON.stringify(bookingInfo)));

                channel.ack(msg); // Acknowledge the message
            } catch (error) {
                console.error('Error processing booking info:', error);
            }
        });
    } catch (error) {
        console.error('Error receiving booking info:', error);
    }
}

// Graceful shutdown
process.on('SIGINT', async () => {
    try {
        console.log('Shutting down...');
        if (channel) {
            await channel.close(); // Close the channel
        }
        process.exit(0);
    } catch (error) {
        console.error('Error during shutdown:', error);
        process.exit(1);
    }
});

(async () => {
    try {
        await db();
        SocketListener.start(io);
        dispatcher().then(() => console.log('Booking dispatcher service started'));

        // Health check
        app.get('/health_check', (req, res) => {
            res.status(200).json({ status: 'OK' });
        });

        // Health check
        app.get('/requestTripFromCustomer', async (req, res) => {
            try {

                const trip = req.body;
                const payload = {
                    "lat": trip.sourceLocation.lat,
                    "lng": trip.sourceLocation.lng,
                    "trip_type": req.body.type,
                };
                // Call the /find-drivers API
                const response = await axios.post('http://python-dispatcher-services:3014/find_drivers', payload);
                // tài xế tiềm năng
                // response = [driver01,driver02]

                // tạo room cho driver và customer 
                // Send booking info to the driver
                if (userActive[response.data.driver[0].id.toString()]) {

                    io.to(userActive[response.data.driver[0].id.toString()]).emit('newTrip', trip);

                } else {
                    console.log(`Client ${response.data.driver[0].id.toString()} not allowed.`);
                }

                // // Send response back to the client
                res.status(200).json({ status: 'OK', driversData: response.data });


            } catch (error) {
                console.error('Error calling /find-drivers:', error.message);
                res.status(500).json({ status: 'Error', message: error.message });
            }
        });

        // Start server
        server.listen(config.PORT, () => {
            console.log(`Server is running on port ${config.PORT}`);
        });
    } catch (error) {
        console.error('Error starting the application:', error);
    }
})();