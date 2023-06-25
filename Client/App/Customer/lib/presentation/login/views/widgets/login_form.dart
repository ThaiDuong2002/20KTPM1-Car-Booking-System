import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKeyLogin = GlobalKey<FormState>();
  final _formKeySignup = GlobalKey<FormState>();
  String? identify, password;
  bool isRegisterTab = false;
  int _currentIndex = 0;
  int expandedFlex = 3;
  void _handleTabTap(int index) {
    setState(() {
      _currentIndex = index;
      isRegisterTab = (_currentIndex == 1);
      expandedFlex = isRegisterTab ? expandedFlex = 7 : expandedFlex = 4;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Container(
                color: Colors.orange,
                child: Image.asset(
                  'assets/images/login/5.png',
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            Expanded(
              flex: expandedFlex,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: DefaultTabController(
                  length: 2,
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: TabBar(
                          labelColor: Colors.black,
                          isScrollable: true,
                          labelStyle: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          onTap: _handleTabTap,
                          tabs: [
                            Tab(text: 'Đăng nhập'),
                            Tab(text: 'Đăng kí'),
                          ],
                        ),
                      ),
                      Expanded(
                        child: TabBarView(
                          physics: const NeverScrollableScrollPhysics(),
                          children: [
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                              transform: Matrix4.translationValues(
                                _currentIndex *
                                    -MediaQuery.of(context).size.width,
                                0,
                                0,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Form(
                                  key: _formKeyLogin,
                                  child: Column(
                                    children: <Widget>[
                                      TextFormField(
                                        decoration: InputDecoration(
                                          labelText: 'Số điện thoại hoặc email',
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                        ),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Vui lòng nhập số điện thoại hoặc email';
                                          }
                                          return null;
                                        },
                                        onChanged: (value) {
                                          setState(() {
                                            identify = value;
                                          });
                                        },
                                      ),
                                      const SizedBox(height: 10),
                                      TextFormField(
                                        decoration: InputDecoration(
                                          labelText: 'Mật khẩu',
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                        ),
                                        obscureText: true,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Vui lòng nhập mật khẩu';
                                          }
                                          return null;
                                        },
                                        onChanged: (value) {
                                          setState(() {
                                            password = value;
                                          });
                                        },
                                      ),
                                      if ((identify?.isNotEmpty ?? false) &&
                                          (password?.isNotEmpty ?? false))
                                        ElevatedButton(
                                          onPressed: () {
                                            if (_formKeyLogin.currentState!
                                                .validate()) {
                                              // If the form is valid, display a Snackbar.
                                            }
                                          },
                                          child: const Text('Đăng nhập'),
                                        ),
                                      Expanded(
                                        flex: 1,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: <Widget>[
                                            const Divider(
                                              color: Colors.grey,
                                              height: 10,
                                              thickness: 1,
                                              indent: 20,
                                              endIndent: 20,
                                            ),
                                            ElevatedButton(
                                              style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all<
                                                        Color>(
                                                  Colors.grey.shade300,
                                                ),
                                              ),
                                              onPressed: () {},
                                              child: const Text(
                                                'Đăng nhập với Google',
                                                style: TextStyle(
                                                    color: Colors.black),
                                              ),
                                            ),
                                            ElevatedButton(
                                              style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all<
                                                        Color>(
                                                  Colors.grey.shade300,
                                                ),
                                              ),
                                              onPressed: () {},
                                              child: const Text(
                                                'Đăng nhập với Facebook',
                                                style: TextStyle(
                                                    color: Colors.black),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                              transform: Matrix4.translationValues(
                                (_currentIndex - 1) *
                                    -MediaQuery.of(context).size.width,
                                0,
                                0,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Form(
                                  key: _formKeySignup,
                                  child: Column(
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Expanded(
                                            child: TextFormField(
                                              decoration: InputDecoration(
                                                labelText: 'Họ',
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                ),
                                              ),
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return 'Vui lòng nhập Họ';
                                                }
                                                return null;
                                              },
                                            ),
                                          ),
                                          const SizedBox(width: 30),
                                          Expanded(
                                            child: TextFormField(
                                              decoration: InputDecoration(
                                                labelText: 'Tên',
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                ),
                                              ),
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return 'Vui lòng nhập Tên';
                                                }
                                                return null;
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      TextFormField(
                                        decoration: InputDecoration(
                                          labelText: 'Số điện thoại',
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                        ),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Vui lòng nhập số điện thoại';
                                          }
                                          return null;
                                        },
                                      ),
                                      const SizedBox(height: 10),
                                      TextFormField(
                                        decoration: InputDecoration(
                                          labelText: 'Email',
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                        ),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Vui lòng nhập email';
                                          }
                                          return null;
                                        },
                                      ),
                                      const SizedBox(height: 10),
                                      TextFormField(
                                        decoration: InputDecoration(
                                          labelText: 'Mật khẩu',
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                        ),
                                        obscureText: true,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Vui lòng nhập mật khẩu';
                                          }
                                          return null;
                                        },
                                      ),
                                      const SizedBox(height: 10),
                                      ElevatedButton(
                                        onPressed: () {
                                          if (_formKeySignup.currentState!
                                              .validate()) {
                                            // Xử lý submit form đăng kí
                                          }
                                        },
                                        child: const Text('Đăng kí'),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
