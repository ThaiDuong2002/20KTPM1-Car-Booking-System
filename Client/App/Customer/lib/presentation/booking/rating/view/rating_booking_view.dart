import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user/presentation/booking/rating/view/rating_booking_page.dart';

import '../blocs/rating_bloc.dart';
class RatingView extends StatelessWidget {
const RatingView({super.key});
@override
Widget build(BuildContext context) {
return  Scaffold(
  body: BlocProvider(create: (context) => RatingBloc(), child: RatingPage())
);
}
}