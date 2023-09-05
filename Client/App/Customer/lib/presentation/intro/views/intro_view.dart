import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:user/app/constant/color.dart';
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
                         
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              const TextCustom(
                                  text: 'An toàn là sự ưu tiên của chúng tôi ',
                                  color: Colors.black,
                                  fontSize: 16,
                                  maxLines: 2,
                                  fontWeight: FontWeight.bold),
                              SizedBox(
                                height: 10,
                              ),
                              const TextCustom(
                                  textAlign: TextAlign.center,
                                  text:
                                      ' Mỗi chuyến đi của bạn, chúng tôi luôn đặt sự an toàn lên hàng đầu',
                                  color: Colors.black,
                                  fontSize: FONT_SIZE_NORMAL,
                                  maxLines: 2,
                                  fontWeight: FontWeight.normal),
                            ],
                          ),
                        ),
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
                          
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              const TextCustom(
                                  text: 'Chia sẻ cảm nhận, nâng tầm dịch vụ ',
                                  color: Colors.black,
                                  fontSize: 16,
                                  maxLines: 2,
                                  fontWeight: FontWeight.bold),
                              SizedBox(
                                height: 10,
                              ),
                              const TextCustom(
                                  textAlign: TextAlign.center,
                                  text:
                                      ' Mọi ý kiến của bạn giúp chúng tôi hoàn thiện hơn mỗi ngày.',
                                  color: Colors.black,
                                  fontSize: FONT_SIZE_NORMAL,
                                  maxLines: 2,
                                  fontWeight: FontWeight.normal),
                            ],
                          ),
                        ),
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
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              const TextCustom(
                                  text: 'Đặt xe nhanh chóng và tiện lợi',
                                  color: Colors.black,
                                  fontSize: 16,
                                  maxLines: 2,
                                  fontWeight: FontWeight.bold),
                              SizedBox(
                                height: 10,
                              ),
                              const TextCustom(
                                  textAlign: TextAlign.center,
                                  text:
                                      ' Lựa chọn hoàn hảo cho mỗi chuyến đi của bạn! ',
                                  color: Colors.black,
                                  fontSize: FONT_SIZE_NORMAL,
                                  maxLines: 2,
                                  fontWeight: FontWeight.normal),
                            ],
                          ),
                        ),
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
                      activeColor:
                          COLOR_BLUE_MAIN, // Current page indicator color
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
