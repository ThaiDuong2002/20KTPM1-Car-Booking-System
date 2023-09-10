import 'package:driver/global/services/bloc/chat/chat_bloc.dart';
import 'package:driver/global/services/bloc/chat/chat_event.dart';
import 'package:driver/global/services/bloc/chat/chat_state.dart';
import 'package:driver/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatSocketPage extends StatefulWidget {
  const ChatSocketPage({super.key});

  @override
  State<ChatSocketPage> createState() => _ChatSocketPageState();
}

class _ChatSocketPageState extends State<ChatSocketPage> {
  final TextEditingController _textEditingController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return BlocListener<ChatBloc, ChatState>(
      listener: (context, state) {
        if (state is ChatMessageSent) {
          _textEditingController.clear();
        } else if (state is ChatMessageReceived) {
          BlocProvider.of<ChatBloc>(context).add(const ChatLoading());
        }
      },
      child: BlocBuilder<ChatBloc, ChatState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Chat App'),
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    controller: _scrollController,
                    itemCount: chat.messages.length,
                    itemBuilder: (context, index) {
                      return Row(
                        mainAxisAlignment: chat.messages[index]['role'] == 'customer'
                            ? MainAxisAlignment.start
                            : MainAxisAlignment.end,
                        children: [
                          Column(
                            crossAxisAlignment: chat.messages[index]['role'] == 'customer'
                                ? CrossAxisAlignment.start
                                : CrossAxisAlignment.end,
                            children: [
                              Container(
                                margin: const EdgeInsets.all(10.0),
                                padding: const EdgeInsets.all(10.0),
                                width: chat.messages[index]['content'].length > 50
                                    ? MediaQuery.of(context).size.width * 0.7
                                    : null,
                                decoration: BoxDecoration(
                                  color: chat.messages[index]['role'] == 'customer'
                                      ? Colors.blue[100]
                                      : Colors.green[100],
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                child: Text(
                                  chat.messages[index]['content'],
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                  ),
                                  softWrap: true,
                                  maxLines: 5,
                                ),
                              ),
                              Container(
                                margin: chat.messages[index]['role'] == 'customer'
                                    ? const EdgeInsets.only(left: 10)
                                    : const EdgeInsets.only(right: 10),
                                padding: chat.messages[index]['role'] == 'customer'
                                    ? const EdgeInsets.only(left: 10)
                                    : const EdgeInsets.only(right: 10),
                                child: Text(
                                  chat.messages[index]['createdAt'],
                                ),
                              )
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _textEditingController,
                          decoration: InputDecoration(
                            hintText: 'Type a message',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.send),
                        onPressed: () {
                          BlocProvider.of<ChatBloc>(context).add(
                            ChatMessageSending(
                              roomId: bookingSocket.bookingId,
                              role: 'driver',
                              content: _textEditingController.text,
                              createdAt: DateTime.now().toString().substring(11, 16),
                            ),
                          );
                          _scrollController.animateTo(
                            _scrollController.position.maxScrollExtent,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeOut,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
