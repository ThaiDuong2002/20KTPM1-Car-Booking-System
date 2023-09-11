import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user/presentation/booking/chat_socket/bloc/chat_bloc.dart';
import 'package:user/presentation/booking/chat_socket/views/chat_socket_page.dart';

class ChatSocketView extends StatelessWidget {
  const ChatSocketView({super.key});
  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
      create: (context) => ChatBloc(),
      child: ChatSocketPage(),
    );
  }
}
