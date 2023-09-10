import 'package:driver/global/services/bloc/chat/chat_event.dart';
import 'package:driver/global/services/bloc/chat/chat_state.dart';
import 'package:driver/main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(const ChatInitial()) {
    bookingSocket.socket.on('chat', (data) {
      add(ChatMessageReceiving(
        roomId: data['roomId'],
        role: data['role'],
        content: data['content'],
        createdAt: data['createdAt'],
      ));
    });

    on<ChatLoading>((event, emit) {
      emit(const ChatInitial());
    });

    on<ChatMessageSending>((event, emit) {
      bookingSocket.socket.emit('chat', {
        'roomId': event.roomId,
        'role': event.role,
        'content': event.content,
        'createdAt': event.createdAt,
      });

      emit(ChatMessageSent(
        roomId: event.roomId,
        role: event.role,
        content: event.content,
        createdAt: event.createdAt,
      ));
    });

    on<ChatMessageReceiving>((event, emit) {
      chat.addMessage({
        'roomId': event.roomId,
        'role': event.role,
        'content': event.content,
        'createdAt': event.createdAt,
      });
      emit(ChatMessageReceived(
        roomId: event.roomId,
        role: event.role,
        content: event.content,
        createdAt: event.createdAt,
      ));
    });
  }
}
