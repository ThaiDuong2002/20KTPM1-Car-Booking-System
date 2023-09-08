import 'package:bloc/bloc.dart';
import 'package:driver/global/services/booking/bloc/booking_event.dart';
import 'package:driver/global/services/booking/bloc/booking_state.dart';
import 'package:driver/main.dart';
import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  BookingBloc() : super(const BookingInitialState()) {
    try {
      bookingSocket.socket.on('newTrip', (data) {
        debugPrint("test " + data.toString());
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
          customerImage: data['customerImage'],
        ));
      });

      on<BookingWaitingEvent>((event, emit) {
        emit(const BookingInitialState());
      });

      on<BookingRequestingEvent>((event, emit) {
        debugPrint("test " + event.toString());
        emit(BookingRequestedState(
          sourceLocation: event.sourceLocation,
          destinationLocation: event.destinationLocation,
          sourceName: event.sourceName,
          destinationName: event.destinationName,
          distance: event.distance,
          price: event.price,
          customerName: event.customerName,
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
