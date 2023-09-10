import 'package:driver/global/endpoints/location_socket_endpoint.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class BookingSocket {
  static final io.Socket _socket = io.io(socketHardUrl, <String, dynamic>{
    'transports': ['websocket'],
    'autoConnect': false,
  });

  static var _bookingId = '';

  void dispose() {
    _socket.disconnect();
  }

  void setBookingId(String id) {
    _bookingId = id;
  }

  void toggleSwitch(bool value) {
    if (value) {
      startListening();
    } else {
      dispose();
    }
  }

  get socket => _socket;
  get bookingId => _bookingId;

  void startListening() {
    _socket.connect();
  }

  void sendFirstRegister(String socketName) {
    _socket.emit(socketName, '123');
  }

  void acceptedTrip(String socketName, dynamic data) {
    _socket.emit(socketName, data);
  }

  void rejectedTrip(String socketName, dynamic data) {
    _socket.emit(socketName, data);
  }

  void startTrip(String socketName, dynamic data) {
    _socket.emit(socketName, data);
  }

  void endTrip(String socketName, dynamic data) {
    _socket.emit(socketName, data);
  }
}
