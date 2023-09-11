import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class InProgressEvent {}

class InProgressEventWaiting extends InProgressEvent {
  final LatLng currentLocationDriver;

  InProgressEventWaiting(this.currentLocationDriver);
}

class InProgressEventDriverArrivedLocation extends InProgressEvent {}

class InprogressEventStartTrip extends InProgressEvent {}

class InProgressEventInformationDriver extends InProgressEvent {}
class InProgressEventInformationEndTrip extends InProgressEvent {}