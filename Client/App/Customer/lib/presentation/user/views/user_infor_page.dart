import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user/presentation/user/bloc/user_event.dart';
import 'package:user/presentation/user/views/user_infor_view.dart';

import '../bloc/user_bloc.dart';

class UserInforPage extends StatelessWidget {
  const UserInforPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
          create: (context) => UserInformation()..add(UserEventFetchData()),
          child: UserInforView()),
    );
  }
}
