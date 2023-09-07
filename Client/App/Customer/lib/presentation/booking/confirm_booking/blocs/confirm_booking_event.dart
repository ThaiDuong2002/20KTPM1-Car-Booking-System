class ConfirmBookingEvent {
  
}

class ConfirmBookinggetData extends ConfirmBookingEvent {

  double distance;
  ConfirmBookinggetData({
    required this.distance,
  });
}
