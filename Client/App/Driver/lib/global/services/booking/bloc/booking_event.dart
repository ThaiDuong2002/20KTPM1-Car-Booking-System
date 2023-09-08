import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class BookingEvent {
  const BookingEvent();
}

class BookingWaitingEvent extends BookingEvent {
  const BookingWaitingEvent();
}

class BookingRequestingEvent extends BookingEvent {
  LatLng sourceLocation;
  LatLng destinationLocation;
  String sourceName;
  String destinationName;
  double distance;
  double price;
  String customerName;
  String customerPhone;
  String customerImage;
  BookingRequestingEvent({
    required this.sourceLocation,
    required this.destinationLocation,
    required this.sourceName,
    required this.destinationName,
    required this.distance,
    required this.price,
    required this.customerName,
    required this.customerPhone,
    required this.customerImage,
  });
}

class BookingAcceptingEvent extends BookingEvent {
  LatLng sourceLocation;
  LatLng destinationLocation;
  String sourceName;
  String destinationName;
  double distance;
  double price;
  String customerName;
  String customerPhone;
  String customerImage;
  BookingAcceptingEvent({
    required this.sourceLocation,
    required this.destinationLocation,
    required this.sourceName,
    required this.destinationName,
    required this.distance,
    required this.price,
    required this.customerName,
    required this.customerPhone,
    required this.customerImage,
  });
}

class BookingRejectingEvent extends BookingEvent {
  const BookingRejectingEvent();
}

class BookingInProgressEvent extends BookingEvent {
  
  LatLng sourceLocation;
  LatLng destinationLocation;
  String sourceName;
  String destinationName;
  BookingInProgressEvent({
    required this.sourceLocation,
    required this.destinationLocation,
    required this.sourceName,
    required this.destinationName,
  });
}

class BookingFinishEvent extends BookingEvent {
  const BookingFinishEvent();
}
