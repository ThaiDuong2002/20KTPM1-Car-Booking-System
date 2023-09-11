import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../model/driver_model.dart';

class InProgressState extends Equatable{
  @override
  List<Object?> get props => [];
}

class InProgressInitial extends InProgressState {

}
class InProgresssStateWaiting extends InProgressState {
  final  Set<Polyline> points;
  final  LatLng markersLatLong ;
  InProgresssStateWaiting({
    required this.points,
    required this.markersLatLong,
  });
 
  
}
class InProgressDriverArrivedLocation extends InProgressState {}

class InpProgressInformationDriver extends InProgressState {
  Driver? driver  ;
  InpProgressInformationDriver({
    required this.driver,
  });
}

class InProgressStateStartTrip extends InProgressState {

  Set<Polyline> points ;
  InProgressStateStartTrip({
    required this.points,
  });

}
class InProgressStateFinishTrip extends InProgressState {
}