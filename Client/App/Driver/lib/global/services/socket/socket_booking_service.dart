import 'package:driver/global/endpoints/location_socket_endpoint.dart';
import 'package:flutter/foundation.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class BookingSocket {
  static final BookingSocket _instance = BookingSocket._internal();

  factory BookingSocket() {
    return _instance;
  }

  BookingSocket._internal();

  late io.Socket _socket;

  void initilize(String socketUrl) {
    _socket = io.io(socketUrl, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    _socket.connect();
  }

  void dispose() {
    _socket.disconnect();
  }

  void toggleSwitch(bool value) {
    if (value) {
      startListening();
    } else {
      dispose();
    }
  }

  void startListening() {
    initilize(socketListenUrl);
    _socket.on('driver-listening', (data) {
      debugPrint(data.toString());
    });
    _socket.on('coordinate', (data) {
      debugPrint(data.toString());
    });
  }
}
