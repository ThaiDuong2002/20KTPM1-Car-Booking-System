import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:user/presentation/booking/in_progress/bloc_promotion/promotion_bloc.dart';

import '../../in_progress/bloc_promotion/promotion_event.dart';
import '../blocs/confirm_booking_bloc.dart';
import '../blocs/confirm_booking_event.dart';
import 'confirm_booking_page.dart';

class ConfirmBookingView extends StatelessWidget {
  const ConfirmBookingView({super.key, required this.data});

  final data;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(
          providers: [
            BlocProvider<ConfirmBookingBloc>(
              create: (context) => ConfirmBookingBloc()
                ..add(ConfirmBookinggetData(
                    distance: data.pickUpLocation.distance)),
            ),
            BlocProvider<PromotionBloc>(
              create: (context) =>
                  PromotionBloc()..add(PromotionEventFetchData()),
            ),
          ],
          child: ConfirmBookingPage(
            data: data,
          )),
    );
  }
}
