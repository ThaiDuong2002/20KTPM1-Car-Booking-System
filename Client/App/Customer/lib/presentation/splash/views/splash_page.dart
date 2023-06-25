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
    return Timer(Duration(seconds: 2), () {
      pref.getUserInfo().then((value) => {
            // Goi API để check token có hết hạn hay chưa, nếu token chưa hết hạn thì chuyển sang trang home, nếu hết hạn thì show Dialog "Hết phiên đăng nhập ! Vui lòng đăng nhập lại"
            if (value.isNotEmpty)
              {Navigator.pushNamed(context, AppRouterName.homePage)}
            else
              {Navigator.pushNamed(context, AppRouterName.loginPage)}
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
     return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: const Image(
          image: AssetImage("assets/images/splash/background.png"),
          fit: BoxFit.fitWidth,
        ),
      ),
    );
  }
}
