import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user/app/constant/color.dart';
import 'package:user/app/constant/size.dart';
import 'package:user/presentation/booking/chat_socket/bloc/chat_event.dart';
import 'package:user/presentation/widget/custom_text.dart';

import '../bloc/chat_bloc.dart';
import '../bloc/chat_state.dart';

class Message {
  final String role;
  final String content;

  Message(this.role, this.content);
}

class ChatSocketPage extends StatefulWidget {
  const ChatSocketPage({super.key});

  @override
  State<ChatSocketPage> createState() => _ChatSocketPageState();
}

class _ChatSocketPageState extends State<ChatSocketPage> {
  TextEditingController textEditingController = TextEditingController();
  static List<Map<String, dynamic>> messages = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_outlined,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        title: TextCustom(
            text: "Nhắn tin với tài xế",
            color: COLOR_TEXT_BLACK,
            fontSize: FONT_SIZE_LARGE,
            fontWeight: FontWeight.w500),
      ),
      body: Column(
        children: [
          Expanded(
              child: BlocListener<ChatBloc, ChatState>(
            listener: (context, state) {
              print(state);
              if (state is ChatStateSuccess) {
                setState(() {
                  messages.add({
                    "role": "customer",
                    "message": state.message,
                  });
                });
              }
              
            },
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return Row(
                  mainAxisAlignment: messages[index]["role"] == "customer"
                      ? MainAxisAlignment.start
                      : MainAxisAlignment.end,
                  children: [
                    Container(
                      margin: EdgeInsets.all(10.0),
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: messages[index]["role"] == "customer"
                            ? Colors.blue[100]
                            : Colors.green[100],
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Column(
                        children: [
                          Text(
                            messages[index]["message"],
                            maxLines: 5,
                          ),
                          Text(
                            messages[index]['createdAt'].toString(),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          )),
          Padding(
            padding:
                const EdgeInsets.only(bottom: 35.0, left: 10.0, right: 10.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: textEditingController,
                    decoration: InputDecoration(
                      hintText: 'Type a message',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    BlocProvider.of<ChatBloc>(context).add(ChatEventSendMessage(
                      roomId: "64f17fd10036d9ad3dde74ff",
                      role: 'customer',
                      content: textEditingController.text,
                      createdAt: DateTime.now().toString().substring(11, 16),
                    ));
                    textEditingController.clear();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
