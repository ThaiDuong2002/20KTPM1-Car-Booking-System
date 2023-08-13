// const amqp = require('amqplib');
import amqp from 'amqplib'
console.log("123");
async function sendCustomerInfo() {
    // Create connection
    const connection = await amqp.connect('amqps://vngvsmvq:7HyyAKl8WOvm_sAVtUDyj1KgWhe0Hqqe@gerbil.rmq.cloudamqp.com/vngvsmvq');
    // Create channel
    const channel = await connection.createChannel();
    // Declaration
    const exchangeName = 'customer_exchange';
    const routingKey = 'customer.info';
    // Mock customer info
    const customerInfo = {
        customer_name: "John Doe2",
        customer_phone: "0795907075",
        trip_pickup_location: "12/5 Tan Hang, phuong 10, quan 5, TP HCM",
        type: "car",
        exist: true,
    };
    // Create exchange
    await channel.assertExchange(exchangeName, 'direct', { durable: false });
    // Publish message
    for (var i = 0; i < 100; i++) {
        channel.publish(exchangeName, routingKey, Buffer.from(JSON.stringify(customerInfo)));
        // setTimeout(() => {

        // }, 200);
    }
    console.log(` [x] Sent customer info:`, customerInfo);
    setTimeout(() => {
        connection.close();
        process.exit(0);
    }, 500);
}
sendCustomerInfo();
