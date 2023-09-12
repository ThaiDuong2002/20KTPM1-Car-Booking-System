import 'package:dio/dio.dart';
import 'package:driver/global/services/bloc/auth/auth_bloc.dart';
import 'package:driver/global/services/bloc/auth/auth_event.dart';
import 'package:driver/global/services/bloc/auth/auth_state.dart';
import 'package:driver/global/services/exceptions/auth_exception.dart';
import 'package:driver/global/utils/constants/colors.dart';
import 'package:driver/global/utils/constants/size.dart';
import 'package:driver/global/utils/helpers/dialogs/error_dialog.dart';
import 'package:driver/global/utils/helpers/navigation/launch_screen.dart';
import 'package:driver/global/utils/style/common_style.dart';
import 'package:driver/global/widgets/app_button.dart';
import 'package:driver/global/widgets/app_textfield.dart';
import 'package:driver/global/widgets/common_widget.dart';
import 'package:driver/global/widgets/header_widget.dart';
import 'package:driver/modules/authentication/register/register_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final dio = Dio();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool mIsCheck = false;
  bool isAcceptedTc = false;

  String? privacyPolicy;
  String? termsCondition;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        switch (state.runtimeType) {
          case UserNotFoundAuthException:
            await showErrorDialog(context, 'User credentials are not valid');
            break;
          case GenericAuthException:
            await showErrorDialog(context, 'Something went wrong');
            break;
        }
      },
      child: Scaffold(
        body: Stack(
          children: [
            const SizedBox(
              height: headerWidgetHeight,
              child: HeaderWidget(),
            ),
            SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 316),
                    Text(
                      'Welcome Back !',
                      style: boldTextStyle(size: 32),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Login to your account',
                      style: primaryTextStyle(),
                    ),
                    const SizedBox(height: 32),
                    AppTextField(
                      controller: emailController,
                      autoFocus: false,
                      textFieldType: TextFieldType.EMAIL,
                      keyboardType: TextInputType.name,
                      errorThisFieldRequired: 'This field is required',
                      decoration: inputDecoration(
                        context,
                        label: 'Email/Phone',
                      ),
                    ),
                    const SizedBox(height: 20),
                    AppTextField(
                      controller: passwordController,
                      autoFocus: false,
                      textFieldType: TextFieldType.PASSWORD,
                      keyboardType: TextInputType.visiblePassword,
                      errorThisFieldRequired: 'This field is required',
                      decoration: inputDecoration(
                        context,
                        label: 'Password',
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              height: 18.0,
                              width: 18.0,
                              child: Checkbox(
                                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                activeColor: primaryColor,
                                value: mIsCheck,
                                shape: RoundedRectangleBorder(borderRadius: radius(2)),
                                onChanged: (v) async {},
                              ),
                            ),
                            const SizedBox(width: 8),
                            inkWellWidget(
                              onTap: () async {
                                mIsCheck = !mIsCheck;
                                setState(() {});
                              },
                              child: Text(
                                'Remember me',
                                style: primaryTextStyle(size: 14),
                              ),
                            ),
                          ],
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: inkWellWidget(
                            onTap: () {
                              hideKeyboard(context);
                            },
                            child: Text(
                              'Forgot password?',
                              style: boldTextStyle(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 50),
                    AppButtonWidget(
                        width: MediaQuery.of(context).size.width,
                        color: primaryColor,
                        textStyle: boldTextStyle(color: Colors.white),
                        text: 'Log In',
                        onTap: () async {
                          context.read<AuthBloc>().add(AuthLoginEvent(
                                identifier: emailController.text,
                                password: passwordController.text,
                              ));
                        }),
                    const SizedBox(height: 16),
                    const SizedBox(height: 16),
                    Align(
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Don\'t have an account?',
                            style: primaryTextStyle(),
                          ),
                          const SizedBox(width: 8),
                          inkWellWidget(
                            onTap: () {
                              hideKeyboard(context);
                              launchScreen(
                                context,
                                const RegisterView(),
                                pageRouteAnimation: PageRouteAnimation.SlideBottomTop,
                              );
                            },
                            child: Text(
                              'Sign Up',
                              style: boldTextStyle(color: primaryColor),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
