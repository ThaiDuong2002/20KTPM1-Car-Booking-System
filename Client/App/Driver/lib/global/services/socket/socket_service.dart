import 'package:flutter/foundation.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class SocketService with ChangeNotifier {
  io.Socket? _socket;
  final String? socketUrl;

  SocketService(this.socketUrl) {
    initilize();
  }

  void initilize() {
    _socket = io.io(socketUrl, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    _socket!.connect();
    _socket!.on(
        'newTrip',
        (data) => {
              debugPrint(data.toString()),
            });
  }

  void disconnect() {
    _socket!.disconnect();
    _socket = null;
  }

  io.Socket getSocket() {
    return _socket!;
  }

  void emit(String event, dynamic data) {
    _socket!.emit(event, data);
  }

  void on(String event, Function(dynamic data) callback) {
    _socket!.on(event, (data) {
      callback(data);
    });
  }
}
