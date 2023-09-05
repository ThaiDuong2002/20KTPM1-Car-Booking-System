import amqp from 'amqplib';
import dotenv from 'dotenv';

dotenv.config();
async function sendBookingInfo() {
    // Create connection
    const connection = await amqp.connect(process.env.KEY_MQ);

    // Create channel
    const channel = await connection.createChannel();

    // Declaration
    const exchangeName = 'customer_exchange';
    const routingKey = 'booking.info';

    // Mock customer info
    const bookingInfo = {
        consultant_id: "1",
        customer_name: "Nguyen Van A",
        customer_phone: "123456789",
        trip_pickup_location: {
            address: "Ho Chi Minh University of Science",
            coordinate: {
                x: 10.772700,
                y: 106.698100,
            },
        },
        trip_destination_location: {
            address: "Ho Chi Minh University of Education",
            coordinate: {
                x: 0.15,
                y: 0.15,
            },
        },
        trip_type: "bike",
    };

    // Create exchange
    await channel.assertExchange(exchangeName, 'direct', { durable: false });

    // Publish message
    channel.publish(exchangeName, routingKey, Buffer.from(JSON.stringify(bookingInfo)));

    console.log(` [x] Sent booking info:`, bookingInfo);

    setTimeout(() => {
        connection.close();
        process.exit(0);
    }, 500);
}

sendBookingInfo().then(() => console.log("Sent booking info"));
