import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService with ChangeNotifier {
  static final SocketService _instance = SocketService._internal();

  factory SocketService() {
    return _instance;
  }

  SocketService._internal() {
    _connect();
  }

  IO.Socket? socket;
  String? _message;

  String? get message => _message;

  void _connect() {
    if (socket != null) return;

    socket =
        IO.io('https://2955-115-73-217-121.ngrok-free.app', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });
    ;

    socket!.on('connect', (_) {
      print('Connected');
    });

    socket!.emit("registerClientId", "456");

    socket!.connect();
  }

  void disconnect() {
    socket?.disconnect();
  }

  void sendMessage(String message, dynamic data) {
    socket?.emit(message, {'data': data});
  }

  @override
  void dispose() {
    disconnect();
    super.dispose();
  }
}
