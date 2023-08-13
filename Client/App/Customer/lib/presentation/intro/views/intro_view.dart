import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:user/app/constant/size.dart';
import 'package:user/presentation/presentation.dart';
import 'package:user/presentation/widget/custom_text.dart';

class IntroView extends StatefulWidget {
  const IntroView({super.key});

  @override
  State<IntroView> createState() => _IntroViewState();
}

int _currentIndex = 0;

final controller = PageController(
  initialPage: _currentIndex,
);

class _IntroViewState extends State<IntroView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 5,
              child: PageView(
                controller: controller,
                allowImplicitScrolling: true,
                onPageChanged: (value) => setState(() => _currentIndex = value),
                children: <Widget>[
                  Column(
                    children: [
                      Expanded(
                        flex: 9,
                        child: Container(
                          height: double.infinity,
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                          ),
                          child: const Image(
                            image: AssetImage("assets/images/login/1.png"),
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                            alignment: Alignment.center,
                            child: const TextCustom(
                                text: "An toàn là sự ưu tiên của chúng tôi",
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold)),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Expanded(
                        flex: 9,
                        child: Container(
                          height: double.infinity,
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                          ),
                          child: const Image(
                            image: AssetImage("assets/images/login/2.png"),
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                            alignment: Alignment.center,
                            child: const TextCustom(
                                text: "Đánh giá và phản hồi dịch vụ",
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold)),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Expanded(
                        flex: 9,
                        child: Container(
                          height: double.infinity,
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                          ),
                          child: const Image(
                            image: AssetImage("assets/images/login/3.png"),
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                            alignment: Alignment.center,
                            child: const TextCustom(
                                text: "Đặt xe nhanh chóng và tiện lợi",
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold)),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
                flex: 1,
                child: DotsIndicator(
                    dotsCount: 3, // Number of pages
                    position: _currentIndex,
                    decorator: const DotsDecorator(
                      activeColor: Colors.blue, // Current page indicator color
                    ))),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              const Color.fromRGBO(84, 121, 247, 1)),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginPage()));
                        },
                        child: const TextCustom(
                            text: "Đăng nhập",
                            color: Colors.white,
                            fontSize: FONT_SIZE_NORMAL,
                            fontWeight: FontWeight.bold)),
                    ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              const Color.fromRGBO(152, 185, 254, 1)),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginPage()));
                        },
                        child: const TextCustom(
                            text: "Đăng kí",
                            color: Colors.black,
                            fontSize: FONT_SIZE_NORMAL,
                            fontWeight: FontWeight.bold)),
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
