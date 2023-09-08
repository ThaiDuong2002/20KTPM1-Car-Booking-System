import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:user/app/constant/color.dart';
import 'package:user/app/constant/size.dart';
import 'package:user/app/routes/route_name.dart';
import 'package:user/presentation/widget/custom_text.dart';

import '../../../data/common/module/shared_pref_module.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final SharedPreferenceModule pref = SharedPreferenceModule();

  @override
  void initState() {
    super.initState();
    startSplash();
  }

  startSplash() async {
    return Timer(const Duration(seconds: 4), () {
      pref.getUserInfo().then((value) => {
            // Goi API để check token có hết hạn hay chưa, nếu token chưa hết hạn thì chuyển sang trang home, nếu hết hạn thì show Dialog "Hết phiên đăng nhập ! Vui lòng đăng nhập lại"
            if (value.isNotEmpty)
              {Navigator.pushNamed(context, AppRouterName.navigation)}
            else
              {Navigator.pushNamed(context, AppRouterName.introPage)}
          });
    });
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/splash/logo.png',
              width: 100,
              height: 100,
            ),
            Lottie.asset('assets/splash.json',
                width: double.infinity, height: 200),
            SizedBox(
              height: 20,
            ),
            TextCustom(
                textAlign: TextAlign.center,
                text: 'Chào mừng bạn đến với ứng dụng đặt xe \n RideNow',
                color: COLOR_TEXT_BLACK,
                fontSize: FONT_SIZE_LARGE,
                maxLines: 2,
                fontWeight: FontWeight.w700)
          ],
        ),
      ),
    );
  }
}
