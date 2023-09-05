import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/confirm_booking_bloc.dart';
import 'confirm_booking_page.dart';

class ConfirmBookingView extends StatelessWidget {
  const ConfirmBookingView({super.key, required this.data});

  final data;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
          create: (context) => ConfirmBookingBloc(),
          child: ConfirmBookingPage(
            data: data,
          )),
    );
  }
}
