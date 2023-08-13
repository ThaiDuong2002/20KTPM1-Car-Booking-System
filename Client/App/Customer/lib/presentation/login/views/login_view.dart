import 'package:flutter/material.dart';
import 'package:user/presentation/navigation/navigation.dart';
import 'package:user/presentation/widget/custom_text.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKeyLogin = GlobalKey<FormState>();
  final _formKeySignup = GlobalKey<FormState>();
  bool isRegisterTab = false;
  int _currentIndex = 0;
  int expandedFlex = 3;
  String? identify, password;

  void _handleTabTap(int index) {
    setState(() {
      _currentIndex = index;
      isRegisterTab = (_currentIndex == 1);
      expandedFlex = isRegisterTab ? 7 : 3;
    });
  }

  Widget LoginForm() {
    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height * 0.65,
        ),
        child: IntrinsicHeight(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Form(
                  key: _formKeyLogin,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Số điện thoại hoặc email',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
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
                            borderRadius: BorderRadius.circular(10.0),
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
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKeyLogin.currentState!.validate()) {
                            // If the form is valid, display a Snackbar.
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const NavigationBottom()));
                          }
                        },
                        child: TextCustom(
                            text: "Đăng nhập",
                            color: Colors.white.withOpacity(0.9),
                            fontSize: 13,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
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
                            backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.grey.shade300,
                            ),
                          ),
                          onPressed: () {},
                          child: TextCustom(
                              text: "Đăng nhập với Google",
                              color: Colors.black.withOpacity(0.5),
                              fontSize: 13,
                              fontWeight: FontWeight.bold)),
                      ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.grey.shade300,
                            ),
                          ),
                          onPressed: () {},
                          child: TextCustom(
                              text: "Đăng nhập với Facebook",
                              color: Colors.black.withOpacity(0.5),
                              fontSize: 13,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
        child: Column(
          children: <Widget>[
            _buildHeaderImage(),
            _buildBody(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderImage() {
    return Expanded(
      flex: 2,
      child: Image.asset(
        'assets/images/login/5.png',
        fit: BoxFit.fitWidth,
      ),
    );
  }

  Widget _buildBody() {
    return Expanded(
      flex: expandedFlex,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: DefaultTabController(
          length: 2,
          child: Column(
            children: [
              _buildTabBar(),
              _buildTabBarView(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabBar() {
    return Align(
      alignment: Alignment.centerLeft,
      child: TabBar(
        labelColor: Colors.black,
        isScrollable: true,
        labelStyle: const TextStyle(
          fontSize: 15.0,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        unselectedLabelColor: Colors.grey,
        onTap: _handleTabTap,
        tabs: const [
          Tab(text: 'Đăng nhập'),
          Tab(text: 'Đăng kí'),
        ],
      ),
    );
  }

  Widget _buildTabBarView() {
    var SignupForm = Padding(
      padding: const EdgeInsets.all(10.0),
      child: Form(
        key: _formKeySignup,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Họ',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
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
                          borderRadius: BorderRadius.circular(10.0),
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
                    borderRadius: BorderRadius.circular(10.0),
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
                    borderRadius: BorderRadius.circular(10.0),
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
                    borderRadius: BorderRadius.circular(10.0),
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
                  if (_formKeySignup.currentState!.validate()) {
                    // Xử lý submit form đăng kí
                  }
                },
                child: const Text('Đăng kí'),
              ),
            ],
          ),
        ),
      ),
    );
    return Expanded(
      child: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        children: [
          LoginForm(),
          SignupForm,
        ],
      ),
    );
  }
}
