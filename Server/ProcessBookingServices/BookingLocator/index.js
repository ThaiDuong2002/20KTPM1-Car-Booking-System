import express from 'express';
import process from "process";
import dotenv from 'dotenv';
import amqp from "amqplib";

dotenv.config();

const app = express();
const config = process.env

import BookingLocator from "./app.js";
import GoogleService from "./services/googleService.js";
import TwilioService from "./services/TwilioService.js";
import GoongService from "./services/goongService.js";

// App Kernel
const bookingLocator = new BookingLocator();

// Services
const googleService = new GoogleService();
const goongService = new GoongService()
const twilioService = new TwilioService();

// Register services
bookingLocator.registerService('googleService', googleService);
bookingLocator.registerService('twilioService', twilioService);
bookingLocator.registerService('goongService', goongService);

let connection = null;
let channel = null;

// Run app
async function locator() {
    try {
        connection = await amqp.connect(config.AMQP_URL);
        channel = await connection.createChannel();
        const exchangeName = config.EXCHANGE_NAME;
        const queueName = config.QUEUE_NAME;
        const routingKey = config.LOCATOR_ROUTING_KEY;
        await channel.assertExchange(exchangeName, 'direct', {durable: false});
        const assertQueueResponse = await channel.assertQueue(queueName);
        const queue = assertQueueResponse.queue;
        channel.bindQueue(queue, exchangeName, routingKey);
        console.log(`[*] Booking locator.`);
        console.log(`[*] Waiting for booking info.`);

        // Consume message
        await channel.consume(queue, async (msg) => {
            if(msg !== null) {
                const bookingInfo = JSON.parse(msg.content.toString());
                console.log(`[x] Received booking info:`, bookingInfo);

                const pickupCoordinate = bookingInfo.pickupLocation;
                const destinationCoordinate = bookingInfo.destinationLocation;
                let message_data
                let locatedCoordinate
                try {
                    if (!pickupCoordinate.coordinate) {
                        locatedCoordinate = await bookingLocator.executeService('goongService', 'getPlaceCoordinates', pickupCoordinate.address);
                        // locatedCoordinate = await bookingLocator.executeService('googleService', 'getPlaceCoordinates', pickupCoordinate.address);
                        console.log("locatedCoordinate", locatedCoordinate)
                        if (locatedCoordinate.length === 0) {
                            message_data = {
                                message: 'Your pickup address is not found',
                                phone: bookingInfo.customerPhone
                            }
                            // await bookingLocator.executeService('twilioService', 'sendMessage', message_data);
                            throw new Error('Your pickup address is not found');
                        } else {
                            bookingInfo.pickupLocation.coordinate = {
                                lat: locatedCoordinate[0].geometry.location.lat,
                                lng: locatedCoordinate[0].geometry.location.lng,
                            };
                        }
                    }

                    if (!destinationCoordinate.coordinate) {
                        locatedCoordinate = await bookingLocator.executeService('goongService', 'getPlaceCoordinates', destinationCoordinate.address);
                        // locatedCoordinate = await bookingLocator.executeService('googleService', 'getPlaceCoordinates', destinationCoordinate.address);
                        console.log("locatedCoordinate", locatedCoordinate)
                        if (locatedCoordinate.length === 0) {
                            message_data = {
                                message: 'Your destination address is not found',
                                phone: bookingInfo.customerPhone
                            }
                            // await bookingLocator.executeService('twilioService', 'sendMessage', message_data);
                            throw new Error('Your destination address is not found');
                        } else {
                            bookingInfo.destinationLocation.coordinate = {
                                lat: locatedCoordinate[0].geometry.location.lat,
                                lng: locatedCoordinate[0].geometry.location.lng,
                            };
                        }
                    }
                    // Publish to dispatcher
                    const json_string_data = JSON.stringify(bookingInfo)
                    channel.publish(exchangeName, config.DISPATCHER_ROUTING_KEY, Buffer.from(json_string_data));
                } catch (error) {
                    console.log("Locator Error: ", error.message)
                } finally {
                    channel.ack(msg); // Acknowledge the message
                }
            } else {
                console.log("Locator Error: No message received");
            }
        });
    } catch (error) {
        console.log("Error receiving booking info:", error.message);
    }
}

locator().then(() => console.log('Booking locator service started'));

// Graceful shutdown
process.on('SIGINT', async () => {
    try {
        console.log('Shutting down...');
        if (channel) {
            await channel.close(); // Close the channel
        }
        if (connection) {
            await connection.close(); // Close the connection
        }
        process.exit(0);
    } catch (error) {
        console.error('Error during shutdown:', error);
        process.exit(1);
    }
});

// Health check
app.get("/health_check", (req, res) => {
    res.status(200).json({status: "OK"});
});

// Start server
app.listen(config.PORT, () => {
    console.log(`Server is running on port ${config.PORT}`);
});