import 'package:bloc/bloc.dart';
import 'package:driver/global/services/bloc/booking/booking_event.dart';
import 'package:driver/global/services/bloc/booking/booking_state.dart';
import 'package:driver/main.dart';
import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  BookingBloc() : super(const BookingInitialState()) {
    try {
      bookingSocket.socket.on('newTrip', (data) {
        final source = LatLng(
          data['sourceLocation']['lat'],
          data['sourceLocation']['lng'],
        );
        final destination = LatLng(
          data['destinationLocation']['lat'],
          data['destinationLocation']['lng'],
        );
        add(BookingRequestingEvent(
          sourceLocation: source,
          destinationLocation: destination,
          sourceName: data['sourceName'],
          destinationName: data['destinationName'],
          distance: data['distance'],
          price: data['price'],
          customerName: data['customerName'],
          customerPhone: data['customerPhone'],
          userId: data['userId'],
          customerImage: data['customerImage'],
          type: data['type'],
          promotionId: data['promotionId'],
          paymentMethodId: data['paymentMethodId'],
        ));
      });

      bookingSocket.socket.on('bookingId', (data) {
        debugPrint('bookingId: $data');
        bookingSocket.setBookingId(data);
      });

      bookingSocket.socket.on('chat', (data) {
        debugPrint('chat: $data');
      });

      on<BookingWaitingEvent>((event, emit) {
        emit(const BookingInitialState());
      });

      on<BookingRequestingEvent>((event, emit) {
        emit(BookingRequestedState(
          sourceLocation: event.sourceLocation,
          destinationLocation: event.destinationLocation,
          sourceName: event.sourceName,
          destinationName: event.destinationName,
          distance: event.distance,
          price: event.price,
          customerName: event.customerName,
          userId: event.userId,
          type: event.type,
          promotionId: event.promotionId,
          paymentMethodId: event.paymentMethodId,
          customerPhone: event.customerPhone,
          customerImage: event.customerImage,
        ));
      });

      on<BookingAcceptingEvent>((event, emit) {
        emit(BookingAcceptedState(
          sourceLocation: event.sourceLocation,
          destinationLocation: event.destinationLocation,
          sourceName: event.sourceName,
          destinationName: event.destinationName,
          distance: event.distance,
          price: event.price,
          customerName: event.customerName,
          userId: event.userId,
          type: event.type,
          promotionId: event.promotionId,
          paymentMethodId: event.paymentMethodId,
          customerPhone: event.customerPhone,
          customerImage: event.customerImage,
        ));
      });

      on<BookingRejectingEvent>((event, emit) {
        emit(const BookingRejectedState());
      });

      on<BookingInProgressEvent>((event, emit) {
        emit(BookingStartRidingState(
          sourceLocation: event.sourceLocation,
          destinationLocation: event.destinationLocation,
          sourceName: event.sourceName,
          destinationName: event.destinationName,
        ));
      });

      on<BookingFinishEvent>((event, emit) {
        emit(const BookingFinishRidingState());
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
