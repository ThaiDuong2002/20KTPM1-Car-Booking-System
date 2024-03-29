import express from "express";
import http from "http";
import cors from "cors";
import { Server } from "socket.io";

const app = express();
const server = http.createServer(app);
const io = new Server(server, {
  cors: {
    origin: "http://localhost:4002",
  },
});

var corsOptions = {
  origin: "http://localhost:4002",
};
app.use(cors(corsOptions));
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

app.post("/notify", (req, res) => {
  const body = req.body;
  const title = "New Booking";
  const notificationData = { title, body };
  io.emit("notification", notificationData);
  res.send("Message was sent");
});

io.on("connection", (socket) => {
  console.log("Client connected");
  socket.on("disconnect", () => {
    console.log("Client disconnected");
  });
});

const port = 5000;
server.listen(port, () => {
  console.log(`Server is running on port ${port}`);
});
