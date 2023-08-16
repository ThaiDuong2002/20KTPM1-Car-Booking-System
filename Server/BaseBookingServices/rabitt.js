const amqp = require('amqplib');
const express = require('express');
const process = require('process'); // Import the process module
const dotenv = require('dotenv');
dotenv.config();
const app = express();
const port = process.env.PORT;
let channel; // Declare the channel at a higher scope
// Function to handle receiving customer info
async function receiveCustomerInfo() {
    try {
        const connection = await amqp.connect('amqp://localhost');
        channel = await connection.createChannel(); // Store the channel reference
        const exchangeName = 'customer_exchange';
        const queueName = 'customer_queue';
        const routingKey = 'customer.info';
        await channel.assertExchange(exchangeName, 'direct', { durable: false });
        const assertQueueResponse = await channel.assertQueue(queueName);
        const queue = assertQueueResponse.queue;
        channel.bindQueue(queue, exchangeName, routingKey);
        console.log(`[*] Waiting for customer info. To exit press CTRL+C`);
        // Consume message
        await channel.consume(queue, async (msg) => {
            try {
                const customerInfo = JSON.parse(msg.content.toString());
                console.log(`[x] Received customer info:`, customerInfo);
                // Process the received customer info
                channel.ack(msg); // Acknowledge the message
            } catch (error) {
                console.error('Error processing customer info:', error);
                // Handle the error (e.g., retry, log, etc.)
            }
        });
    } catch (error) {
        console.error('Error receiving customer info:', error);
    }
}
// Start receiving customer info
receiveCustomerInfo().then(() =>
    console.log('Customer info reception started')
);
// Health check
app.get('/health_check', (req, res) => {
    res.status(200).json({ status: 'OK' });
});
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
app.listen(port, () => {
    console.log(`Server is running on port ${port}`);
});