const SocketListener = {
    start: function (io) {


        io.on('connect', function (socket) {
            console.log('a user connected 123');

            socket.on('registerClientId', function (clientId) {
                if (Object.keys(userActive).length < 2) {
                    userActive[clientId] = socket.id;
                    console.log(`Client ${clientId} has connected.`);
                } else {
                    console.log('More than two clients trying to connect!');
                }
            });

            socket.on('messageToOtherClient', function (data) {
                const { clientId, message } = data;

                if (userActive[clientId]) {

                    io.to(userActive[clientId]).emit('messageFromOtherClient', message);
                    console.log(`Message from client ${clientId} forwarded.`);
                } else {
                    console.log(`Client ${clientId} not allowed.`);
                }
            });

            socket.on('start_trip', function (data) {
                console.log(data);
                socket.broadcast.emit('start_trip_driver', data);
            });

            socket.on('accepted_trip', function (data) {
                console.log(data);


                // tạo booking ở đây
                // tạo axios
                var id_booing = "64f17fd10036d9ad3dde74ff";
                io.to(userActive[data.driverId]).emit("bookingId", id_booing);
                io.to(userActive[data.userId]).emit("bookingId", id_booing);
                socket.join(id_booing);
                userActive[data.userId]
                io.sockets.sockets.get(userActive[data.userId]).join(id_booing);


            });

            socket.on("chat", function (data) {
                console.log(data);
                const { bookingId, content } = data;
                console.log(bookingId);
                console.log(content);
                io.to(bookingId).emit("chat", content);

            })

            socket.on('finish_trip', function (data) {
                console.log(data);
                socket.broadcast.emit('finish_trip_driver', data);
            });
            socket.on('deny_trip', function (data) {
                console.log(data);
                // socket.broadcast.emit('finish_trip_driver', data);
                // Xử lý deny ở đây
            });
            
            socket.on('driver-location', function (data) {
                console.log(data);
                socket.broadcast.emit('coordinate', data);
            });

            socket.on('disconnect', function () {
                console.log('user disconnected');
                const disconnectedClientId = Object.keys(userActive).find(
                    key => userActive[key] === socket.id
                );
                if (disconnectedClientId) {
                    delete userActive[disconnectedClientId];
                    console.log(`Client ${disconnectedClientId} has disconnected.`);
                }
            });
        });
    },
};

export default SocketListener;
