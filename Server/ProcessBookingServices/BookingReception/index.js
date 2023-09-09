import express from "express";
import process from "process";
import dotenv from "dotenv";
import amqp from "amqplib";

dotenv.config();

const app = express();
const config = process.env;

let channel = null;

async function reception() {
  try {
    const connection = await amqp.connect(config.AMQP_URL);
    channel = await connection.createChannel(); // Store the channel reference
    const exchangeName = config.EXCHANGE_NAME;
    const queueName = config.QUEUE_NAME;
    const routingKey = config.RECEPTION_ROUTING_KEY;
    await channel.assertExchange(exchangeName, "direct", { durable: false });
    const assertQueueResponse = await channel.assertQueue(queueName);
    const queue = assertQueueResponse.queue;
    channel.bindQueue(queue, exchangeName, routingKey);
    console.log(`[*] Booking reception.`);
    console.log(`[*] Waiting for customer info.`);

    // Consume message
    await channel.consume(queue, async (msg) => {
      try {
        const bookingInfo = JSON.parse(msg.content.toString());
        console.log(`[x] Received customer info:`, bookingInfo);
        // console.log(bookingInfo.pickupLocation.coordinate);
        // console.log(bookingInfo.destinationLocation.coordinate);
        const channel = await connection.createChannel();
        await channel.assertExchange(exchangeName, "direct", {
          durable: false,
        });
        if (
          bookingInfo.pickupLocation.coordinate != null &&
          bookingInfo.destinationLocation.coordinate != null
        ) {
          channel.publish(
            exchangeName,
            config.DISPATCHER_ROUTING_KEY,
            Buffer.from(JSON.stringify(bookingInfo))
          );
          console.log("Send to booking dispatcher");
        } else {
          channel.publish(
            exchangeName,
            config.LOCATOR_ROUTING_KEY,
            Buffer.from(JSON.stringify(bookingInfo))
          );
          console.log("Send to booking locator");
        }
        // channel.ack(msg); // Acknowledge the message
      } catch (error) {
        console.error("Error processing customer info:", error);
      }
    });
  } catch (error) {
    console.error("Error receiving customer info:", error);
  }
}

reception().then(() => console.log("Customer info reception started"));

// Graceful shutdown
process.on("SIGINT", async () => {
  try {
    console.log("Shutting down...");
    if (channel) {
      await channel.close(); // Close the channel
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
