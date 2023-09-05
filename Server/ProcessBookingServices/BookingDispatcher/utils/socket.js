
const SocketListener = {
    start: function (io) {
        console.log("Vô đây không");
        io.on('connect', function (socket) {
            // console.log(req.app.io);
            //implement with category ,product, confirm order
            console.log('a user connected 123');

            socket.on('disconnect', function () {
                const disconnectedUserId = Object.keys(global.userActive).find(
                    (key) => global.userActive[key] === socket.id
                );
                if (disconnectedUserId) {
                    delete global.userActive[disconnectedUserId];
                    console.log(`User ${disconnectedUserId} has disconnected.`);
                    console.log(global.userActive);
                }
            });
        });
    },
};
// config socket
export default SocketListener;
