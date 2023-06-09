import 'dart:async';

import 'package:flutter/material.dart';
import 'package:user/app/routes/route_name.dart';

import '../../../data/common/module/shared_pref_module.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final SharedPreferenceModule pref = SharedPreferenceModule();

  startSplash() async {
    print("Vo day hong");
    return Timer(Duration(seconds: 2), () {
      pref.getUserInfo().then((value) => {
            if (value.isNotEmpty)
              {
                Navigator.pushNamed(context, AppRouterName.homePage)
              }
            else
              {
                Navigator.pushNamed(context, AppRouterName.loginPage)
              }
          });
    });
  }

  @override
  void initState() {
    super.initState();
    startSplash();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
          child: Center(
        child: Text("Splash screen"),
      )),
    );
  }
}
