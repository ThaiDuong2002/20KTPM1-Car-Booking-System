import express from "express";
import process from "process";
import dotenv from "dotenv";
import amqp from "amqplib";

dotenv.config();

const app = express();
const config = process.env;
let connection = null
let channel = null;

async function reception() {
    try {
        connection = await amqp.connect(config.AMQP_URL);
        channel = await connection.createChannel();
        const exchangeName = config.EXCHANGE_NAME;
        const queueName = config.QUEUE_NAME;
        const routingKey = config.RECEPTION_ROUTING_KEY;
        await channel.assertExchange(exchangeName, "direct", { durable: false });
        const assertQueueResponse = await channel.assertQueue(queueName);
        const queue = assertQueueResponse.queue;
        channel.bindQueue(queue, exchangeName, routingKey);
        console.log(`[*] Booking reception.`);
        console.log(`[*] Waiting for booking info.`);

        // Consume message
        channel.consume(queue, (msg) => {
            if (msg !== null) {
                const bookingInfo = JSON.parse(msg.content.toString());
                console.log(`[x] Received booking info:`, bookingInfo);

                // Publish to locator or dispatcher
                const json_string_data = JSON.stringify(bookingInfo)
                if (bookingInfo.pickupLocation.coordinate != null && bookingInfo.destinationLocation.coordinate != null) {
                    channel.publish(exchangeName, config.DISPATCHER_ROUTING_KEY, Buffer.from(json_string_data));
                    console.log("[x] Send to booking dispatcher service");
                } else {
                    channel.publish(exchangeName, config.LOCATOR_ROUTING_KEY, Buffer.from(json_string_data))
                    console.log("[x] Send to booking locator service");
                }
                channel.ack(msg); // Acknowledge the message
            } else {
                console.log("Reception Error: No message received");
            }
        });
    } catch (error) {
        console.log("Error receiving booking info:", error.message);
    }
}

reception().then(() => console.log("Booking reception service started"));

// Graceful shutdown
process.on("SIGINT", async () => {
    try {
        console.log("Shutting down...");
        if (channel) {
            await channel.close(); // Close the channel
        }
        if (connection) {
            await connection.close(); // Close the connection
        }
        process.exit(0);
    } catch (error) {
        console.error("Error during shutdown:", error);
        process.exit(1);
    }
});

// Health check
app.get("/health_check", (req, res) => {
    res.status(200).json({ status: "OK" });
});

// Start server
app.listen(config.PORT, () => {
    console.log(`Server is running on port ${config.PORT}`);
});