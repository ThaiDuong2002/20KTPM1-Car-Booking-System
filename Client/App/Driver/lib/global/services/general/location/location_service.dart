import 'dart:async';
import 'dart:isolate';

import 'package:driver/global/endpoints/location_socket_endpoint.dart';
import 'package:driver/global/services/general/location/location_permission.dart';
import 'package:driver/global/services/general/socket/socket_service.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GeolocationService {
  Future<Position> getCurrentLocation() async {
    try {
      return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
    } catch (e) {
      return Future.error(e);
    }
  }
}

class LocationService extends ChangeNotifier {
  late SocketService _socketService;
  late Isolate _isolate;
  LatLng? _currentPosition;

  Future<void> init() async {
    // final ipAddress = IpAddress();
    // final socketUrl = await ipAddress.socketUrl();
    _socketService = SocketService(socketHardUrl);
    _socketService.initilize();
  }

  
  void disposeService() {
    _isolate.kill();
    _socketService.disconnect();
  }

  void toggleSwitch(bool value) {
    if (value) {
      startIsolates();
    } else {
      disposeService();
    }
  }

  LatLng? get currentPosition => _currentPosition;

  //test
  static void _isolateEntryPoints(SendPort sendPortToMain) {
    final receivePortFromMain = ReceivePort();
    sendPortToMain.send(receivePortFromMain.sendPort);

    receivePortFromMain.listen((message) {
      if (message is Map<String, dynamic>) {
        final locationData = message; // Kết quả từ việc tính toán trong Isolate
        // TODO: Bạn có thể thực hiện nhiều tính toán hơn ở đây nếu cần
        sendPortToMain.send(locationData); // Gửi kết quả về luồng chính
      }
    });
  }

  Future<void> startIsolates() async {
    LocationPermissionService permission = LocationPermissionService();
    await permission.determinePosition();
    await init();
    final receivePortFromIsolate = ReceivePort();

    _isolate = await Isolate.spawn(_isolateEntryPoints, receivePortFromIsolate.sendPort);

    receivePortFromIsolate.listen((message) {
      if (message is Map<String, dynamic>) {
        // Nhận dữ liệu từ Isolate
        final locationData = message;
        _currentPosition = LatLng(
          locationData['lat'],
          locationData['lng'],
        );
        notifyListeners();
        // Gửi dữ liệu vị trí qua socket
        _socketService.emit('driver-location', locationData);
      } else if (message is SendPort) {
        final sendPortToIsolate = message;
        // Bắt đầu tính toán và gửi dữ liệu đến Isolate

        _startLocationUpdatess(sendPortToIsolate);
      }
    });
  }

  void _startLocationUpdatess(SendPort sendPortToIsolate) async {
    final location = GeolocationService();
    Timer.periodic(const Duration(seconds: 3), (timer) async {
      final position = await location.getCurrentLocation();
      final locationData = {
        'lat': position.latitude,
        'lng': position.longitude,
      };

      sendPortToIsolate.send(locationData); // Gửi dữ liệu vị trí đến Isolate
    });
  }
}
