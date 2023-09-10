import 'package:driver/global/services/bloc/chat/chat_bloc.dart';
import 'package:driver/modules/rides/chat/widgets/chat_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatSocketView extends StatelessWidget {
  const ChatSocketView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatBloc(),
      child: const ChatSocketPage(),
    );
  }
}
