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

let channel = null;

async function publishBookingInfo(bookingData) {
    const connection = await amqp.connect(config.AMQP_URL);
    const channel = await connection.createChannel();
    const exchangeName = config.EXCHANGE_NAME;
    const routingKey = config.DISPATCHER_ROUTING_KEY;
    await channel.assertExchange(exchangeName, 'direct', {durable: false});
    channel.publish(exchangeName, routingKey, Buffer.from(JSON.stringify(bookingData)));
    console.log(`[x] Booking info:`, bookingData);
    console.log('[x] Sent to booking dispatcher');
}

// Run app
async function locator() {
    try {
        const connection = await amqp.connect(config.AMQP_URL);
        channel = await connection.createChannel(); // Store the channel reference
        const exchangeName = config.EXCHANGE_NAME;
        const queueName = config.QUEUE_NAME;
        const routingKey = config.LOCATOR_ROUTING_KEY;
        await channel.assertExchange(exchangeName, 'direct', {durable: false});
        const assertQueueResponse = await channel.assertQueue(queueName);
        const queue = assertQueueResponse.queue;
        await channel.bindQueue(queue, exchangeName, routingKey);
        console.log(`[*] Booking locator.`);
        console.log(`[*] Waiting for booking info.`);

        // Consume message
        await channel.consume(queue, async (msg) => {
            try {
                const bookingData = JSON.parse(msg.content.toString());
                console.log(`[x] Received booking info:`, bookingData);
                const pickupCoordinate = bookingData.pickupLocation;
                const destinationCoordinate = bookingData.destinationLocation;

                let message_data
                let locatedCoordinate
                if (!pickupCoordinate.coordinate) {
                    // const coordinates = await bookingLocator.executeService('goongService', 'getPlaceCoordinates', pickupCoordinate.address);
                    locatedCoordinate = await bookingLocator.executeService('googleService', 'getPlaceCoordinates', pickupCoordinate.address);
                    if (locatedCoordinate.length === 0) {
                        message_data = {
                            message: 'Your pickup address is not found',
                            phone: bookingData.customerPhone
                        }
                        await bookingLocator.executeService('twilioService', 'sendMessage', message_data);
                    } else {
                        bookingData.pickupLocation.coordinate = {
                            lat: locatedCoordinate[0].geometry.location.lat,
                            lng: locatedCoordinate[0].geometry.location.lng,
                        };
                    }
                }

                if (!destinationCoordinate.coordinate) {
                    // const coordinates = await bookingLocator.executeService('goongService', 'getPlaceCoordinates', pickupCoordinate.address);
                    locatedCoordinate = await bookingLocator.executeService('googleService', 'getPlaceCoordinates', destinationCoordinate.address);
                    if (locatedCoordinate.length === 0) {
                        message_data = {
                            message: 'Your destination address is not found',
                            phone: bookingData.customerPhone
                        }
                        await bookingLocator.executeService('twilioService', 'sendMessage', message_data);
                    } else {
                        bookingData.destinationLocation.coordinate = {
                            lat: locatedCoordinate[0].geometry.location.lat,
                            lng: locatedCoordinate[0].geometry.location.lng,
                        };
                    }
                }

                channel.ack(msg); // Acknowledge the message
                await publishBookingInfo(bookingData);
                console.log(bookingData);
            } catch (error) {
                console.error('Error processing booking info:', error);
            }
        });
    } catch (error) {
        console.error('Error receiving booking info:', error);
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