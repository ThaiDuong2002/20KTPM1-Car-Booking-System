import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:user/model_gobal/pick_des.dart';
import 'package:user/model_gobal/socket_client.dart';

import '../../decode/flexible_polyline.dart';
import '../model/driver_model.dart';
import 'in_progress_event.dart';
import 'in_progress_state.dart';

class InProgressBloc extends Bloc<InProgressEvent, InProgressState> {
  SocketService socketService = SocketService();
  static bool checkInprogress = false;
  static bool checkFinish = false;
  final PickUpAndDestication pickupLocation;
  InProgressBloc(this.pickupLocation) : super(InProgressInitial()) {
    // Lắng nghe sự kiện từ socket
    socketService.socket!.on('information_driver', (data) {
      print(data);
      add(InProgressEventInformationDriver());
    });
    // Lắng nghe sự kiện từ socket
    socketService.socket!.on('tracking-location-customer', (data) {
      print(data);
      try {
        print(data);
        LatLng data1 = LatLng(data['lat'], data['lng']);
        add(InProgressEventWaiting(data1));
        ;
      } catch (e) {
        print(e);
      }
    });
    socketService.socket!.on('bookingId', (data) {
      print("id của thnahf" + data.toString());
    });
    socketService.socket!.on('start_trip_driver', (data) {
      checkInprogress = true;

      print("Nhận data từ socket");

      add(InprogressEventStartTrip());
    });
    socketService.socket!.on('finish_trip_driver', (data) {
      checkInprogress = false;
      checkFinish = true;
      print("Nhận data từ socket");

      add(InProgressEventInformationEndTrip());
    });
    socketService.socket!.on('chat', (data) {
      print("Tin nhắn từ driver Dương" + data.toString());
    });
    on<InProgressEventWaiting>(wattingDriver);
    on<InProgressEventDriverArrivedLocation>(driverArrtivedLocation);
    on<InprogressEventStartTrip>(startTrip);
    on<InProgressEventInformationEndTrip>(finishTrip);
  }

  Future<void> startTrip(
      InprogressEventStartTrip event, Emitter<InProgressState> emit) async {
    emit(InProgressInitial());
    final data = await drawPolylines(
        LatLng(pickupLocation.pickUpLocation!.lat,
            pickupLocation.pickUpLocation!.lng),
        LatLng(pickupLocation.currentPosition!.latitude!,
            pickupLocation.currentPosition!.longitude!));
    emit(InProgressStateStartTrip(points: data));
  }

  Future<void> finishTrip(InProgressEventInformationEndTrip event,
      Emitter<InProgressState> emit) async {
    emit(InProgressInitial());
    await Future.delayed(Duration(seconds: 2));
    emit(InProgressStateFinishTrip());
  }

  Future<void> wattingDriver(
      InProgressEventWaiting event, Emitter<InProgressState> emit) async {
    emit(InProgressInitial());

    final data;
    if (checkInprogress) {
      data = await drawPolylines(
        LatLng(
          pickupLocation.pickUpLocation!.lat,
          pickupLocation.pickUpLocation!.lng,
        ),
        event.currentLocationDriver,
      );
    } else {
      data = await drawPolylines(
        LatLng(
          pickupLocation.currentPosition!.latitude!,
          pickupLocation.currentPosition!.longitude!,
        ),
        event.currentLocationDriver,
      );
    }

    emit(InProgresssStateWaiting(
      points: data,
      markersLatLong: event.currentLocationDriver,
    ));
  }

  Future<void> getInformationDriver(InProgressEventInformationDriver event,
      Emitter<InProgressState> emit) async {
    emit(InProgressInitial());
    await Future.delayed(Duration(seconds: 2));
    emit(InpProgressInformationDriver(
        driver: Driver(
            firstname: "Thành",
            lastname: "Bùi",
            phone: "0368826352",
            driverLicense: "51B - 69405",
            avatar: "123",
            licensePlate: "123",
            star: 4.5)));
  }

  Future<void> driverArrtivedLocation(
      InProgressEvent event, Emitter<InProgressState> emit) async {}

  Future<List<LatLng>> fetchRouteCoordinates(
      LatLng origin, LatLng destination, String apiKey) async {
    try {
      final url =
          'https://router.hereapi.com/v8/routes?origin=${origin.latitude},${origin.longitude}&transportMode=car&destination=${destination.latitude},${destination.longitude};sideOfStreetHint=${origin.latitude},${origin.longitude};matchSideOfStreet=always&return=polyline,summary&apikey=$apiKey';

      final Dio dio = Dio();
      // await Future.delayed(Duration(seconds: 2));
      final response = await dio.get(url);

      if (response.statusCode == 200) {
        final polyline = response.data['routes'][0]['sections'][0]['polyline'];
        final coords = FlexiblePolyline.decode(polyline);
        List<LatLng> data = [];
        coords.forEach((element) {
          print(element);
          data.add(LatLng(element.lat, element.lng));
        });
        return data;
      } else {
        throw Exception('Failed to load route coordinates');
      }
    } catch (e) {
      print(e.toString());
    }
    return [];
  }

  Future<Set<Polyline>> drawPolylines(
      currentPosition_draw, desPosition_draw) async {
    // polylines.clear();
    List<LatLng> routePoints = await fetchRouteCoordinates(currentPosition_draw,
        desPosition_draw, "hEw3XwDy1W81P-plM4aqi0guc50YBNmuKSo9uDkaYvw");

    Set<Polyline> polylines = {};
    polylines.add(Polyline(
      polylineId: PolylineId(currentPosition_draw.toString()),
      visible: true,
      patterns: [PatternItem.dash(10), PatternItem.gap(10)],
      endCap: Cap.roundCap,
      startCap: Cap.roundCap,
      jointType: JointType.round,
      width: 8, //width of polyline
      points: routePoints,
      color: Colors.blue, //color of polyline
    ));

    return polylines;
  }
}
