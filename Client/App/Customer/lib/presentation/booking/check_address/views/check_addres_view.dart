import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user/presentation/booking/check_address/blocs/check_address_event.dart';
import 'package:user/presentation/booking/check_address/views/check_address_page.dart';

import '../blocs/check_address_bloc.dart';

class CheckAddressView extends StatelessWidget {
  const CheckAddressView({super.key, required this.currentLocation});
  final currentLocation;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
          create: (context) => CheckAddressBloc()..add(CheckAddressEventSearch(currentLocation)),
          child: CheckAddressPage(
            currentLocation: currentLocation,
          )),
    );
  }
}
