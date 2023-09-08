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
