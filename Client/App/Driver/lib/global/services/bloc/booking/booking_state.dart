import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class BookingState {
  const BookingState();
}

class BookingInitialState extends BookingState {
  const BookingInitialState();
}

class BookingRequestedState extends BookingState {
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
  BookingRequestedState({
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

class BookingAcceptedState extends BookingState {
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
  BookingAcceptedState({
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

class BookingRejectedState extends BookingState {
  const BookingRejectedState();
}

class BookingStartRidingState extends BookingState {
  LatLng sourceLocation;
  LatLng destinationLocation;
  String sourceName;
  String destinationName;
  BookingStartRidingState({
    required this.sourceLocation,
    required this.destinationLocation,
    required this.sourceName,
    required this.destinationName,
  });
}

class BookingFinishRidingState extends BookingState {
  const BookingFinishRidingState();
}

class BookingLoadingState extends BookingState {
  const BookingLoadingState();
}
