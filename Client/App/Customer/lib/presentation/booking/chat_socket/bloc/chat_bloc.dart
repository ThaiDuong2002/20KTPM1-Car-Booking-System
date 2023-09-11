import 'package:bloc/bloc.dart';
import 'package:user/presentation/booking/chat_socket/bloc/chat_event.dart';
import 'package:user/presentation/booking/chat_socket/bloc/chat_state.dart';

import '../../../../model_gobal/socket_client.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(ChatStateInitial()) {
    final SocketService socketService = SocketService();

    socketService.socket!.on('chat', (data) {
      print("Tin nhắn từ driver Dương 567" + data.toString());

      add(ChatEventReceiveMessage(data['content'].toString()));
    });
    on<ChatEventSendMessage>(sendMessage);
    on<ChatEventReceiveMessage>(receiveMessage);
  }

  Future<void> sendMessage(
      ChatEventSendMessage event, Emitter<ChatState> emit) async {
    emit(ChatStateLoading());
    final SocketService socketService = SocketService();
    socketService.socket!.emit('chat', event.toMap());

    emit(ChatStateSending(message: event.content));
  }

  Future<void> receiveMessage(
      ChatEventReceiveMessage event, Emitter<ChatState> emit) async {
    emit(ChatStateSuccess(message: event.message));
  }
}


