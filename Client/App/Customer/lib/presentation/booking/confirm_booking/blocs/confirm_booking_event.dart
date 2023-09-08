import 'package:google_maps_flutter/google_maps_flutter.dart';

class ConfirmBookingEvent {
  
}

class ConfirmBookinggetData extends ConfirmBookingEvent {

  double distance;
  ConfirmBookinggetData({
    required this.distance,
  });
}

class ConfirmBookingRequestTrip extends ConfirmBookingEvent {
  LatLng sourceLocation;
  LatLng destinationLocation;
  String sourceName;
  String destinationName;
  double distance;
  double price;
  String customerName;
  String customerPhone;
  String customerImage;
  ConfirmBookingRequestTrip({
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
