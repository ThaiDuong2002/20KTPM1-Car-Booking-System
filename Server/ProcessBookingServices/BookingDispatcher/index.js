import amqp from 'amqplib';
import express from 'express';
import process from 'process';
import db from './configs/db.js';
import dotenv from 'dotenv';
import axios from "axios";
import http from "http";
import SocketListener from './utils/socket.js';
dotenv.config();
import { Server } from "socket.io";
const app = express();
const port = process.env.PORT;

const server = http.createServer(app);
const io = new Server(server);

global.userActive = {};
app.use((req, res, next) => {
    req.io = io;
    next();
});



async function getDrivingDistance(origin_x, origin_y, trip_type, drivers_location) {
    console.log("Vô đây không");
    let destination_str = "";
    for (let location of drivers_location) {
        destination_str += `${location.latitude},${location.longitude}|`;
    }
    // Remove the trailing '|' character
    destination_str = destination_str.slice(0, -1);

    const endpoint = `${process.env.GOONG_URL}?origins=${origin_x},${origin_y}&destinations=${destination_str}&vehicle=${trip_type}&api_key=${process.env.GOONG_API_KEY}`;
    console.log(endpoint);
    try {
        const response = await axios.get(endpoint);
        let drivers_distance_list = response.data.rows[0].elements;

        // Add driver id to the list
        for (let i = 0; i < drivers_distance_list.length; i++) {
            drivers_distance_list[i].id = drivers_location[i].id;
        }

        // Sort the list by distance
        drivers_distance_list.sort((a, b) => {
            return a.distance.value - b.distance.value;
        });

        return drivers_distance_list;
    } catch (error) {
        console.error(error.message);
        return null;
    }
}

let channel;

async function dispatcher() {
    try {

        const connection = await amqp.connect(process.env.KEY_MQ);
        channel = await connection.createChannel();

        const exchangeName = 'customer_exchange';
        const queueName = 'dispatcher_queue';
        const routingKey = 'booking.info';

        await channel.assertExchange(exchangeName, 'direct', { durable: false });
        const assertQueueResponse = await channel.assertQueue(queueName);
        const queue = assertQueueResponse.queue;

        await channel.bindQueue(queue, exchangeName, routingKey);

        console.log(`[*] Waiting for booking info. To exit press CTRL+C`);

        // Inside the dispatcher function, after receiving booking info
        await channel.consume(queue, async (msg) => {
            try {
                const bookingInfo = JSON.parse(msg.content.toString());
                console.log(`[x] Received booking info:`, bookingInfo);

                const pickupLocationCoordination = bookingInfo.trip_pickup_location.coordinate;
                const tripType = bookingInfo.trip_type;

                // Get drivers location (db or redis)
                const drivers_location = [
                    { id: 1, latitude: 10.772580, longitude: 106.698028, type: "bike" },
                    { id: 2, latitude: 10.779783, longitude: 106.698930, type: "bike" },
                    { id: 3, latitude: 10.776056, longitude: 106.700854, type: "car" },
                    { id: 4, latitude: 10.779400, longitude: 106.699296, type: "bike" },
                    { id: 5, latitude: 10.771986, longitude: 106.704874, type: "car" },
                    { id: 6, latitude: 10.768097, longitude: 106.692112, type: "bike" },
                    { id: 7, latitude: 10.773104, longitude: 106.706250, type: "car" },
                    { id: 8, latitude: 10.786040, longitude: 106.705215, type: "bike" },
                    { id: 9, latitude: 10.772580, longitude: 106.698028, type: "car" },
                    { id: 10, latitude: 10.776554, longitude: 106.700916, type: "bike" },
                ];

                // const drivers_distance_list = await getDrivingDistance(pickupLocationCoordination.x, pickupLocationCoordination.y, tripType, drivers_location)
                // console.log(drivers_distance_list);

                // // Send booking info to the driver
                // const driverId = drivers_distance_list[0].id;
                // const driverExchangeName = 'driver_exchange';
                // const driverRoutingKey = `driver.${driverId}`;
                // await channel.assertExchange(driverExchangeName, 'direct', { durable: false });
                // await channel.publish(driverExchangeName, driverRoutingKey, Buffer.from(JSON.stringify(bookingInfo)));

            } catch (error) {
                console.error('Error processing booking info:', error);
            }
        });
    } catch (error) {
        console.error('Error receiving booking info:', error);
    }
}

process.on('SIGINT', async () => {
    try {
        console.log('Shutting down...');

        if (channel) {
            await channel.close();
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
        await dispatcher();


        app.get('/health_check', (req, res) => {
            req.io.emit('newMessage', 'A message from /send route 123');
            res.status(200).json({ status: 'OK' });

        });

        server.listen(port, () => {
            console.log(`Server is running on port ${port}`);
        });
    } catch (error) {
        console.error('Error starting the application:', error);
    }
})();
