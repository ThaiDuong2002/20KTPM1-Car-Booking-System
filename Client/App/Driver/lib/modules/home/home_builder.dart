import 'package:driver/global/services/bloc/booking/booking_bloc.dart';
import 'package:driver/modules/home/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBuilder extends StatelessWidget {
  const HomeBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BookingBloc(),
      child: const HomeView(),
    );
  }
}
