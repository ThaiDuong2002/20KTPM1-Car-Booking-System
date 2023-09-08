import 'package:equatable/equatable.dart';
import 'package:user/presentation/booking/confirm_booking/model/item_confirm_booking.dart';

class ConfirmBookingState extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
  
}
class ConfirmBookingInitial extends ConfirmBookingState {}
class ConfirmBookingLoading extends ConfirmBookingState {}
class ConfirmBookingSuccess extends ConfirmBookingState {
  List<ItemConfirmBooking> data;
  ConfirmBookingSuccess({
    required this.data,
  });
}
class ConfirmBookingFailure extends ConfirmBookingState {
  final String message;
  ConfirmBookingFailure({required this.message});
}

class ConfirmBookingHaveDriver extends ConfirmBookingState {
  
}
class ConfirmBookingNoDriver extends ConfirmBookingState {

}
class ConfirmBookingWattingDriver extends ConfirmBookingState {

  
}
