import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user/presentation/booking/in_progress/bloc/in_progress_bloc.dart';
import 'package:user/presentation/booking/in_progress/views/in_pogress_booking.dart';

import '../../../../model_gobal/pick_des.dart';

class InProgressBookingView extends StatelessWidget {
  final PickUpAndDestication data;
  const InProgressBookingView({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => InProgressBloc(data),
      child: InProgressBooking(data: data),
    );
  }
}
