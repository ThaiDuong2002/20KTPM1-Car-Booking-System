import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class NotificationView extends StatefulWidget {
  const NotificationView({super.key});

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  IO.Socket socket = IO.io('http://192.168.31.124:3004', <String, dynamic>{
    'transports': ['websocket'],
  });

  Timer? timer;
  @override
  void initState() {
    super.initState();
    socket.connect();
    print("12366");
    socket.onConnect((_) {
      print('Connected');
    });
    socket.onDisconnect((_) {
      print('Disconnected');
    });
    socket.onConnectError((data) {
      print('Connect error: $data');
    });

    socket.onConnectTimeout((data) {
      print('Connect timeout: $data');
    });

    socket.onError((data) {
      print('Error: $data');
    });
  }

  @override
  void dispose() {
    socket.dispose();
    timer?.cancel();
    super.dispose();
  }

  void startSendingLocation() async {
    timer = Timer.periodic(const Duration(seconds: 15), (Timer t) async {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      socket.emit('driverLocationUpdate',{'latitude': position.latitude, 'longitude': position.longitude});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        automaticallyImplyLeading: false,
        centerTitle: false,
        backgroundColor: Colors.white,
        title: Text('Thông báo',
            style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w700,
                fontSize: 20,
                color: Colors.black)),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: startSendingLocation,
          child: const Text('Accept Ride'),
        ),
      ),
    );
  }
}
