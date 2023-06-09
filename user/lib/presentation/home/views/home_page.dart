import 'package:flutter/material.dart';
import 'package:user/presentation/home/views/home_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: HomeView());
  }
}
