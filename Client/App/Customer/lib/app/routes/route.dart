import 'package:flutter/material.dart'; 
import '../../presentation/presentation.dart';
import 'route_name.dart';

class AppRoute {
  static Route onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments; 
    // check các điều kiện để trả về route tương ứng với settings.name
    switch (settings.name) {
      case AppRouterName.splashPage:
        return MaterialPageRoute(builder: (_) => const SplashPage());
      case AppRouterName.loginPage:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case AppRouterName.homePage:
        return MaterialPageRoute(builder: (_) => const HomePage());
      default:
        _errPage(); 
    }
    return _errPage();
  }

  static Route _errPage() {
    return MaterialPageRoute(builder: (_) {
      return const Scaffold(
        body: Center(
          child: Text('No Router! Please check your configuration'),
        ),
      );
    });
  }
}
