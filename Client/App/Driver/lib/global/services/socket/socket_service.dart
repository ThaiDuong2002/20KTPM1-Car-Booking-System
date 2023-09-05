import 'package:socket_io_client/socket_io_client.dart' as io;

class SocketService {
  io.Socket? _socket;
  final String? socketUrl;

  SocketService(this.socketUrl);

  void initilize() {
    _socket = io.io(socketUrl, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    _socket!.connect();
  }

  void disconnect() {
    _socket!.disconnect();
  }

  io.Socket getSocket() {
    return _socket!;
  }

  void emit(String event, dynamic data) {
    _socket!.emit(event, data);
  }
}
