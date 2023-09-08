import 'package:driver/global/endpoints/location_socket_endpoint.dart';
import 'package:flutter/foundation.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class BookingSocket {
  static final io.Socket _socket = io.io(socketHardUrl, <String, dynamic>{
    'transports': ['websocket'],
    'autoConnect': false,
  });

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

  get socket => _socket;

  void startListening() {
    _socket.connect();
    _socket.on('driver-listening', (data) {
      debugPrint(data.toString());
    });
    _socket.on('newTrip', (data) {});
  }

  void sendFirstRegister(String socketName) {
    _socket.emit(socketName, '123');
  }
}
