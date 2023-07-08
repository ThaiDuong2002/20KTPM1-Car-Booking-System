import 'package:flutter/material.dart';
import 'app/routes/route.dart';
import 'presentation/presentation.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Booking App",
      home: SplashPage(),
      debugShowCheckedModeBanner: false,
      initialRoute: '/splashPage',
      onGenerateRoute: AppRoute.onGenerateRoute,
    );
  }
}
