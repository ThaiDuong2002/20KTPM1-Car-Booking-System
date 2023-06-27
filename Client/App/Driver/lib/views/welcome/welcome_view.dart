import 'package:driver/constants/images.dart';
import 'package:driver/constants/size.dart';
import 'package:driver/helpers/widgets/header_widget.dart';
import 'package:flutter/material.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: headerWidgetHeight,
            child: HeaderWidget(),
          ),
          const SizedBox(
            height: 20,
            child: Text(
              'Welcome to Driver App',
              style: TextStyle(fontSize: 20),
            ),
          ),
          const SizedBox(
            height: 100,
            child: Image(
              image: AssetImage(welcomeImage),
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            child: const Text('Login'),
          ),
          ElevatedButton(
            onPressed: () {},
            child: const Text('Register'),
          ),
        ],
      ),
    );
  }
}
