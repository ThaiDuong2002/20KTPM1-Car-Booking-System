import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user/presentation/intial_booking/views/itinial_booking_view.dart';

import '../../../model_gobal/mylocation.dart';

class InitalBookingPage extends StatelessWidget {
  const InitalBookingPage({super.key});
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: InitialBokingView(),
    );
  }
}
