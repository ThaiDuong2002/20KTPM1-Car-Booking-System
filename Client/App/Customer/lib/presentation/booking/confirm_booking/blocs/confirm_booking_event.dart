import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../model/item_confirm_booking.dart';

class ConfirmBookingEvent {}

class ConfirmBookinggetData extends ConfirmBookingEvent {
  double distance;
  ConfirmBookinggetData({
    required this.distance,
  });
}

class ApplyPromotionEvent extends ConfirmBookingEvent {
  List<ItemConfirmBooking> data;
  final String promotionId;
  final double discount;
  ApplyPromotionEvent({
    required this.data,
    required this.promotionId,
    required this.discount,
  });
}

class ConfirmBookingHaveDataDriver extends ConfirmBookingEvent {}

class ConfirmBookingRequestTrip extends ConfirmBookingEvent {
  final LatLng sourceLocation;
  final LatLng destinationLocation;

  final String sourceName;
  final String destinationName;
  final double distance;
  final double price;
  final String customerName;
  final String customerPhone;
  final String userId;
  final String customerImage;
  final String type;
  final String promotionId;
  final String paymentMethodId;
  ConfirmBookingRequestTrip({
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
