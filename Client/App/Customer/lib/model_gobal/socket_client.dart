import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService with ChangeNotifier {
  IO.Socket? socket;
  String? _message;

  String? get message => _message;

  SocketService() {
    _connect();
  }

  _connect() {
    socket =
        IO.io('https://24a2-42-115-94-181.ngrok-free.app', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    socket!.on('connect', (_) {
      print('Connected');
    });

    // socket!.on('coordinate', (data) {
    //   _message = data.toString();
    //   notifyListeners(); // Notify listeners when a new message arrives
    // });

    socket!.connect();
  }

  disconnect() {
    socket?.disconnect();
  }

  void sendMessage(String message, dynamic data) {
    socket?.emit(message, {
      'data': data,
    }); // This sends a signal named 'accept' to the server
  }

  @override
  void dispose() {
    disconnect();
    super.dispose();
  }
}
