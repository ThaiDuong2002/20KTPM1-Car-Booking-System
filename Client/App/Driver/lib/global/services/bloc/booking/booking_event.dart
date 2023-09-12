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
  String userId;
  String customerImage;
  String type;
  String promotionId;
  String paymentMethodId;
  BookingRequestingEvent({
    required this.sourceLocation,
    required this.destinationLocation,
    required this.sourceName,
    required this.destinationName,
    required this.distance,
    required this.price,
    required this.customerName,
    required this.customerPhone,
    required this.userId,
    required this.customerImage,
    required this.type,
    required this.promotionId,
    required this.paymentMethodId,
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
  String userId;
  String customerImage;
  String type;
  String promotionId;
  String paymentMethodId;
  BookingAcceptingEvent({
    required this.sourceLocation,
    required this.destinationLocation,
    required this.sourceName,
    required this.destinationName,
    required this.distance,
    required this.price,
    required this.customerName,
    required this.customerPhone,
    required this.userId,
    required this.customerImage,
    required this.type,
    required this.promotionId,
    required this.paymentMethodId,
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
  double distance;
  double price;
  String customerName;
  String customerPhone;
  String userId;
  String customerImage;
  String type;
  String promotionId;
  String paymentMethodId;
  BookingInProgressEvent({
    required this.sourceLocation,
    required this.destinationLocation,
    required this.sourceName,
    required this.destinationName,
    required this.distance,
    required this.price,
    required this.customerName,
    required this.customerPhone,
    required this.userId,
    required this.customerImage,
    required this.type,
    required this.promotionId,
    required this.paymentMethodId,
  });
}

class BookingFinishEvent extends BookingEvent {
  LatLng sourceLocation;
  LatLng destinationLocation;
  String sourceName;
  String destinationName;
  double distance;
  double price;
  String customerName;
  String customerPhone;
  String userId;
  String customerImage;
  String type;
  String promotionId;
  String paymentMethodId;
  BookingFinishEvent({
    required this.sourceLocation,
    required this.destinationLocation,
    required this.sourceName,
    required this.destinationName,
    required this.distance,
    required this.price,
    required this.customerName,
    required this.customerPhone,
    required this.userId,
    required this.customerImage,
    required this.type,
    required this.promotionId,
    required this.paymentMethodId,
  });
}
