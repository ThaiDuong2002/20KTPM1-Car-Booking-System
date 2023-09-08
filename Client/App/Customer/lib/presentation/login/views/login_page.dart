import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user/presentation/login/bloc/authen_bloc.dart';
import 'package:user/presentation/login/views/login_view.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: BlocProvider(
        create: (context) => AuthenBloc(),
        child: LoginView(),
        ),
    );
  }
}
