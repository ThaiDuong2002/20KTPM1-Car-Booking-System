import express from "express";
import process from "process";
import dotenv from "dotenv";
import amqp from "amqplib";
import http from "http";
import axios from "axios";
import { Server } from "socket.io";

import db from "./configs/db.js";
import SocketListener from "./utils/socket.js";
import GoongService from "./services/goongService.js";

dotenv.config();

const app = express();
const config = process.env;

const server = http.createServer(app);
const io = new Server(server);
const goongService = new GoongService();

global.userActive = {};
app.use((req, res, next) => {
  req.io = io;
  next();
});

// Dùng body-parser (nếu bạn sử dụng Express < 4.16.0)
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

let connection = null;
let channel = null;

async function dispatcher() {
  try {
    connection = await amqp.connect(config.AMQP_URL);
    channel = await connection.createChannel();
    const exchangeName = config.EXCHANGE_NAME;
    const queueName = config.QUEUE_NAME;
    const routingKey = config.DISPATCHER_ROUTING_KEY;
    await channel.assertExchange(exchangeName, "direct", { durable: false });
    const assertQueueResponse = await channel.assertQueue(queueName);
    const queue = assertQueueResponse.queue;
    channel.bindQueue(queue, exchangeName, routingKey);
    console.log(`[*] Booking dispatcher.`);
    console.log(`[*] Waiting for booking info.`);

    // Consume message
    await channel.consume(queue, async (msg) => {
      if (msg !== null) {
        const bookingInfo = JSON.parse(msg.content.toString());
        console.log(`[x] Received booking info:`, bookingInfo);

        const origins =
          bookingInfo.pickupLocation.coordinate.lat +
          "," +
          bookingInfo.pickupLocation.coordinate.lng;
        const destinations =
          bookingInfo.destinationLocation.coordinate.lat +
          "," +
          bookingInfo.destinationLocation.coordinate.lng;

        let distanceVal;
        let priceVal;

        // axios
        //   .get("https://rsapi.goong.io/DistanceMatrix", {})
        //   .then((response) => {
        //     // distanceVal = response.data.rows[0].elements.map(
        //     //   (element) => element.distance.value
        //     // );
        //     distanceVal = response.data.rows[0].elements[0].distance.value;
        //     console.log("Distance: " + distanceVal);

        //     const requestData = {
        //       distance: distanceVal,
        //       time: "2023-09-04T18:30:00",
        //       tripType: "car",
        //       badWeather: true,
        //     };
        //     const requestBody = JSON.stringify(requestData);
        //     axios
        //       .get("http://price-services:3012/fee", {
        //         data: requestBody,
        //       })
        //       .then((response) => {
        //         priceVal = response.data.data;
        //         console.log("Price", priceVal);
        //       })
        //       .catch((error) => {
        //         console.error("Error:", error);
        //       });
        //   })
        //   .catch((error) => {
        //     console.error("Error:", error);
        //   });

        const distance = 5.06;
        const price = 12143.08;

        const postBody = {
          sourceLocation: bookingInfo.pickupLocation.coordinate,
          destinationLocation: bookingInfo.destinationLocation.coordinate,
          sourceName: bookingInfo.pickupLocation.address,
          destinationName: bookingInfo.destinationLocation.address,
          distance: distance,
          price: price,
          customerName: bookingInfo.customerName,
          customerPhone: bookingInfo.customerPhone,
          userId: "",
          customerImage:
            "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg",
          type: "car",
          promotionId: "",
          paymentMethodId: "",
        };

        console.log("Post Body: ", postBody);

        axios
          .post(
            "http://booking-dispatcher-services:3013/requestTripFromCustomer",
            postBody
          )
          .then((response) => {
            console.log("Response: ", response);
          })
          .catch((error) => {
            console.error("Error:", error);
          });

        // const pickupLocationCoordination = bookingInfo.pickupLocation.coordinate;
        // const tripType = bookingInfo.type;

        // // Get drivers location (db or redis)
        // const drivers_location = [
        //     {id: 1, latitude: 10.772580, longitude: 106.698028, type: "bike"},
        //     {id: 2, latitude: 10.779783, longitude: 106.698930, type: "bike"},
        //     {id: 3, latitude: 10.776056, longitude: 106.700854, type: "car"},
        //     {id: 4, latitude: 10.779400, longitude: 106.699296, type: "bike"},
        //     {id: 5, latitude: 10.771986, longitude: 106.704874, type: "car"},
        //     {id: 6, latitude: 10.768097, longitude: 106.692112, type: "bike"},
        //     {id: 7, latitude: 10.773104, longitude: 106.706250, type: "car"},
        //     {id: 8, latitude: 10.786040, longitude: 106.705215, type: "bike"},
        //     {id: 9, latitude: 10.772580, longitude: 106.698028, type: "car"},
        //     {id: 10, latitude: 10.776554, longitude: 106.700916, type: "bike"},
        // ];

        // const drivers_distance_list = await goongService.getDriverDistanceList(
        //     pickupLocationCoordination.x,
        //     pickupLocationCoordination.y,
        //     tripType,
        //     drivers_location
        // )
        // console.log(drivers_distance_list);

        // // Send booking info to the driver
        // const driverId = drivers_distance_list[0].id;
        // const driverExchangeName = 'driver_exchange';
        // const driverRoutingKey = `driver.${driverId}`;
        // await channel.assertExchange(driverExchangeName, 'direct', { durable: false });
        // await channel.assertExchange(driverExchangeName, 'direct', {durable: false});
        // await channel.publish(driverExchangeName, driverRoutingKey, Buffer.from(JSON.stringify(bookingInfo)));

        channel.ack(msg); // Acknowledge the message
      } else {
        console.log("Dispatcher Error: No message received");
      }
    });
  } catch (error) {
    console.log("Error receiving booking info:", error.message);
  }
}

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

(async () => {
  try {
    await db();
    SocketListener.start(io);
    dispatcher().then(() => console.log("Booking dispatcher service started"));

    // Health check
    app.get("/health_check", (req, res) => {
      req.io.emit("newMessage", "A message from /send route 123");
      res.status(200).json({ status: "OK" });
    });

    // Health check
    app.post("/requestTripFromCustomer", async (req, res) => {
      try {
        // const trip = {
        //     sourceLocation: { lat: 10.763067461221109, lng: 106.68250385945508 }, // Vị trí San Francisco, California
        //     destinationLocation: { lat: 10.75539299045719, lng: 106.68182394229112 }, // Vị trí Los Angeles, California
        //     sourceName: "Trường Đại học Khoa học Tự nhiên,Quận 5",
        //     destinationName: "Cà phê Three O'Clock",
        //     distance: 758.20, // Khoảng cách (km) giữa San Francisco và Los Angeles
        //     price: 84.60,   // Giá tiền
        //     customerName: "Thanh Bui",
        //     customerPhone: "123-456-7890",
        //     customerImage: "https://khoinguonsangtao.vn/wp-content/uploads/2022/08/hinh-anh-avatar-sadboiz.jpg"
        // };

        console.log("ReqBody: ", req.body);
        const trip = req.body;

        const payload = {
          lat: trip.sourceLocation.lat,
          lng: trip.sourceLocation.lng,
          trip_type: req.body.type,
        };
        // Call the /find-drivers API
        const response = await axios.post(
          "http://python-dispatcher-services:3014/find_drivers",
          payload
        );

        // tài xế tiềm năng
        // response = [driver01,driver02]

        // io.on('accept_trip', function (data) {

        //     // create booking schema

        //     console.log(data);
        // });
        // io.on('reject_trip', function (data) {
        //     //loop to last driver to send emit
        //     console.log(data);
        // });

        // Send booking info to the driver
        if (userActive[response.data.driver[0].id.toString()]) {
          console.log(userActive[response.data.driver[0].id.toString()]);
          io.to(userActive[response.data.driver[0].id.toString()]).emit(
            "newTrip",
            trip
          );
        } else {
          console.log(
            `Client ${response.data.driver[0].id.toString()} not allowed.`
          );
        }

        // // Send response back to the client
        res.status(200).json({ status: "OK", driversData: response.data });
      } catch (error) {
        console.error("Error calling /find-drivers:", error.message);
        res.status(500).json({ status: "Error", message: error.message });
      }
    });

    // Start server
    server.listen(config.PORT, () => {
      console.log(`Server is running on port ${config.PORT}`);
    });
  } catch (error) {
    console.error("Error starting the application:", error);
  }
})();
