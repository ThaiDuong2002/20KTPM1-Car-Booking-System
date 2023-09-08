import 'package:bloc/bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:user/model_gobal/pick_des.dart';
import 'package:user/model_gobal/socket_client.dart';

import '../model/driver_model.dart';
import 'in_progress_event.dart';
import 'in_progress_state.dart';

class InProgressBloc extends Bloc<InProgressEvent, InProgressState> {
  SocketService socketService = SocketService();

  final PickUpAndDestication pickupLocation;
  InProgressBloc(this.pickupLocation) : super(InProgressInitial()) {
    // Lắng nghe sự kiện từ socket
    socketService.socket!.on('information_driver', (data) {
      print(data);
      
      add(InProgressEventInformationDriver());
      
    });

    // Lắng nghe sự kiện từ socket
    socketService.socket!.on('coordinate', (data) {
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
    on<InProgressEventWaiting>(wattingDriver);
    on<InProgressEventDriverArrivedLocation>(driverArrtivedLocation);
  }

  Future<void> wattingDriver(
      InProgressEventWaiting event, Emitter<InProgressState> emit) async {
    emit(InProgressInitial());

    emit(InProgresssStateWaiting(event.currentLocationDriver));
    if (event.currentLocationDriver.latitude == 10.7554645 &&
        event.currentLocationDriver.longitude == 106.6818023) {
      emit(InProgressDriverArrivedLocation());
    }
  }


  Future<void> getInformationDriver(
      InProgressEventInformationDriver event, Emitter<InProgressState> emit) async {

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
}
