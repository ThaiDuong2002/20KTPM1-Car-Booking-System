import amqp from "amqplib";
import cors from "cors";
import dotenv from "dotenv";

dotenv.config();

const data = {
  consultant_id: "1",
  customer_name: "Nguyen Van A",
  customer_phone: "123456789",
  trip_pickup_location: {
    address: "Ho Chi Minh University of Science",
    coordinate: null,
  },
  trip_destination_location: {
    address: "Ho Chi Minh University of Education",
    coordinate: null,
  },
  trip_type: "Bike",
};

export async function sendToBookingReception(data) {
  // Create connection
  const connection = await amqp.connect(
    "amqps://vngvsmvq:7HyyAKl8WOvm_sAVtUDyj1KgWhe0Hqqe@gerbil.rmq.cloudamqp.com/vngvsmvq"
  );
  // Create channel
  const channel = await connection.createChannel();
  // Declaration
  const exchangeName = process.env.EXCHANGE_NAME;
  const routingKey = process.env.BOOKING_RECEPTION_ROUTING_KEY;

  //Create exchange
  await channel.assertExchange(exchangeName, "direct", {
    durable: false,
  });
  //Pulish message
  channel.publish(exchangeName, routingKey, Buffer.from(JSON.stringify(data)));

  console.log(` [x] Sent to booking reception service`, data);
  setTimeout(() => {
    connection.close();
    process.exit(0);
  }, 500);
}

// sendToBookingReception(data);
