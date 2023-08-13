import 'package:driver/global/utils/constants/size.dart';
import 'package:driver/global/widgets/header_widget.dart';
import 'package:driver/modules/authentication/welcome/widgets/welcome_image.dart';
import 'package:driver/modules/authentication/welcome/widgets/welcome_login_button.dart';
import 'package:driver/modules/authentication/welcome/widgets/welcome_register_button.dart';
import 'package:flutter/material.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: headerWidgetHeight,
              child: HeaderWidget(),
            ),
            SafeArea(
              child: Container(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Welcome to Driver App',
                      style: TextStyle(
                        fontSize: 60,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const WelcomeImage().build(context),
                    const WelcomeLoginButton().build(context),
                    const WelcomeRegisterButton().build(context),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
