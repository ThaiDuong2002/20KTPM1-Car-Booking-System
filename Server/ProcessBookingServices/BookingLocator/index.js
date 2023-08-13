import amqp from 'amqplib';
import dotenv from 'dotenv';
import express from 'express';
import process from 'process';

dotenv.config();
const app = express();
const port = process.env.PORT;
let channel;

async function receiveBookingInfo() {
  try {
    const connection = await amqp.connect(
      'amqps://vngvsmvq:7HyyAKl8WOvm_sAVtUDyj1KgWhe0Hqqe@gerbil.rmq.cloudamqp.com/vngvsmvq'
    );
    channel = await connection.createChannel(); // Store the channel reference
    const exchangeName = 'booking_exchange';
    const queueName = 'booking_queue';
    const routingKey = 'booking.info';
    await channel.assertExchange(exchangeName, 'direct', { durable: false });
    const assertQueueResponse = await channel.assertQueue(queueName);
    const queue = assertQueueResponse.queue;
    channel.bindQueue(queue, exchangeName, routingKey);
    console.log(`[*] Waiting for customer info. To exit press CTRL+C`);
    // Consume message
    await channel.consume(queue, async (msg) => {
      try {
        const bookingData = JSON.parse(msg.content.toString());
        const pickupCoordinate = bookingData.trip_pickup_location;
        const destinationCoordinate = bookingData.trip_destination_location;

        if (!pickupCoordinate.coordinate) {
          const pickup = await axios.get(process.env.LOCATOR_URL, {
            params: {
              query: pickupCoordinate.address,
              key: process.env.GOOGLE_MAPS_API_KEY,
            },
          });
          if (pickup.data.results.length === 0) {
            client.messages
              .create({
                body: 'Your pickup address is not found',
                to: `+84${bookingData.customer_phone}`, // Text your number
                from: '+13344906324', // From a valid Twilio number
              })
              .then((_) => {
                return;
              });
          } else {
            bookingData.trip_pickup_location.coordinate = {
              x: pickup.data.results[0].geometry.location.lat,
              y: pickup.data.results[0].geometry.location.lng,
            };
          }
        }
        if (!destinationCoordinate.coordinate) {
          const destination = await axios.get(process.env.LOCATOR_URL, {
            params: {
              query: destinationCoordinate.address,
              key: process.env.GOOGLE_MAPS_API_KEY,
            },
          });
          if (destination.data.results.length === 0) {
            client.messages
              .create({
                body: 'Your destination address is not found',
                to: `+84${bookingData.customer_phone}`, // Text your number
                from: '+13344906324', // From a valid Twilio number
              })
              .then((_) => {
                return;
              });
          } else {
            bookingData.trip_destination_location.coordinate = {
              x: destination.data.results[0].geometry.location.lat,
              y: destination.data.results[0].geometry.location.lng,
            };
          }
        }
        channel.ack(msg); // Acknowledge the message
        publishBookingInfo(bookingData);
      } catch (error) {
        console.error('Error processing customer info:', error);
        // Handle the error (e.g., retry, log, etc.)
      }
    });
  } catch (error) {
    console.error('Error receiving customer info:', error);
  }
}

async function publishBookingInfo(bookingInfo) {
  // Create connection
  const connection = await amqp.connect(
    'amqps://vngvsmvq:7HyyAKl8WOvm_sAVtUDyj1KgWhe0Hqqe@gerbil.rmq.cloudamqp.com/vngvsmvq'
  );
  // Create channel
  const channel = await connection.createChannel();
  // Declaration
  const exchangeName = 'booking_locator';
  const routingKey = 'booking.info';
  // Create exchange
  await channel.assertExchange(exchangeName, 'direct', { durable: false });
  // Publish message
  channel.publish(exchangeName, routingKey, Buffer.from(JSON.stringify(bookingInfo)));
  console.log(` [x] Sent customer info:`, bookingInfo);
  setTimeout(() => {
    connection.close();
    process.exit(0);
  }, 500);
}

// Start receiving customer info
receiveBookingInfo().then(() => console.log('Customer info reception started'));
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
