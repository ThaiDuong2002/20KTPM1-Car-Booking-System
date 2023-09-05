import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:user/app/constant/color.dart';
import 'package:user/app/constant/size.dart';
import 'package:user/presentation/login/bloc/authen_bloc.dart';
import 'package:user/presentation/login/bloc/authen_event.dart';
import 'package:user/presentation/login/bloc/authen_state.dart';
import 'package:user/presentation/navigation/navigation.dart';
import 'package:user/presentation/widget/custom_text.dart';

import '../../../data/common/module/shared_pref_module.dart';
import '../../widget/loading.dart';
import '../dto/signup/signup_request.dart';
import '../dto/login/login_request.dart';

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

  TextEditingController _controller_firstname = TextEditingController();
  TextEditingController _controller_lastname = TextEditingController();
  TextEditingController _controller_phone = TextEditingController();
  TextEditingController _controller_email = TextEditingController();
  TextEditingController _controller_password = TextEditingController();
  TextEditingController _controller_indentifier = TextEditingController();
  TextEditingController _controller_password_login = TextEditingController();

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
                        controller: _controller_indentifier,
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
                        controller: _controller_password_login,
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
                            print("Đăng nhập");
                            Navigator.pushNamed(context, '/navigationPage');
                            // LoginRequest request = LoginRequest(
                            //   identifier: _controller_indentifier.text,
                            //   password: _controller_password_login.text,
                            // );
                            // print(request);
                            // BlocProvider.of<AuthenBloc>(context, listen: false)
                            //     .add(AuthenEventLogin(request: request));
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
      body: BlocListener<AuthenBloc, AuthenState>(
        listener: (context, state) {
          // Navigator.of(context).pop();
          print("hahahâ");

          if (state is AuthenStateSuccess) {
            if (Navigator.of(context).canPop()) {
              Navigator.of(context).pop(); // close existing dialog
            }
            showDialog<void>(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Center(
                    child: TextCustom(
                        text: "Đăng kí thành công",
                        color: COLOR_TEXT_BLACK,
                        fontSize: FONT_SIZE_LARGE,
                        fontWeight: FontWeight.bold),
                  ),
                  content: Lottie.asset('assets/register_success.json'),
                  actions: <Widget>[
                    TextButton(
                      style: TextButton.styleFrom(
                        textStyle: Theme.of(context).textTheme.labelLarge,
                      ),
                      child: TextCustom(
                          text: "Đăng nhập ngay",
                          color: Colors.black.withOpacity(0.5),
                          fontSize: FONT_SIZE_NORMAL,
                          fontWeight: FontWeight.bold),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
          }
          if (state is AuthenStateLoginSucess) {
            try {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const NavigationBottom()));
            } catch (e) {
              print(e.toString());
            }
          }
          if (state is AuthenStateFailure) {
            if (Navigator.of(context).canPop()) {
              Navigator.of(context).pop(); // close existing dialog
            }
            showDialog<void>(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Center(
                    child: TextCustom(
                        text: "Đăng kí thất bại",
                        color: COLOR_TEXT_BLACK,
                        fontSize: FONT_SIZE_LARGE,
                        fontWeight: FontWeight.bold),
                  ),
                  content: TextCustom(
                      text: state.message ?? "Vui lòng kiểm tra lại thông tin",
                      color: COLOR_TEXT_BLACK,
                      fontSize: FONT_SIZE_NORMAL,
                      fontWeight: FontWeight.normal),
                  actions: <Widget>[
                    TextButton(
                      style: TextButton.styleFrom(
                        textStyle: Theme.of(context).textTheme.labelLarge,
                      ),
                      child: TextCustom(
                          text: "Tiếp tục",
                          color: Colors.black.withOpacity(0.5),
                          fontSize: FONT_SIZE_NORMAL,
                          fontWeight: FontWeight.bold),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
          }
          if (state is AuthenStateLoading) {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return LoadingDialog();
                });
          }
        },
        child: BlocBuilder<AuthenBloc, AuthenState>(
          builder: (context, state) {
            return Container(
              color: Colors.white,
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
              child: Column(
                children: <Widget>[
                  SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                  _buildHeaderImage(),
                  _buildBody(),
                ],
              ),
            );
          },
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
                      controller: _controller_firstname,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
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
                      controller: _controller_lastname,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
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
                controller: _controller_phone,
                autovalidateMode: AutovalidateMode.onUserInteraction,
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
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: _controller_email,
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
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: _controller_password,
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
                    SignUpRequest request = SignUpRequest(
                      firstname: _controller_firstname.text,
                      lastname: _controller_lastname.text,
                      phone: _controller_phone.text,
                      email: _controller_email.text,
                      password: _controller_password.text,
                    );
                    // Xử lý submit form đăng kí
                    print(request);
                    BlocProvider.of<AuthenBloc>(context, listen: false)
                        .add(AuthenEventSignUp(request: request));
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
