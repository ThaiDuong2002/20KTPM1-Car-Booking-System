import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:user/presentation/login/views/widgets/login_form.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

int _currentIndex = 0;

final controller = PageController(
  initialPage: _currentIndex,
);

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 6,
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
                      flex: 1,
                      child:
                          Text("An toàn nhanh gọn là sự ưu tiên của chúng tôi"),
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
                      flex: 1,
                      child: Text("Đánh giá tài xế sau khi tới điểm đến"),
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
                      flex: 1,
                      child: Text("Đặt xe nhanh chóng và tiện lợi"),
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
                  decorator: DotsDecorator(
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
                          Colors.lightBlueAccent),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginForm()));
                    },
                    child: Text('Đăng nhập'),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('Đăng kí'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
