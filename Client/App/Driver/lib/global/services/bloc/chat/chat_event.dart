abstract class ChatEvent {
  const ChatEvent();
}

class ChatLoading extends ChatEvent {
  const ChatLoading();
}

class ChatMessageSending extends ChatEvent {
  String roomId;
  String role;
  String content;
  String createdAt;

  ChatMessageSending({
    required this.roomId,
    required this.role,
    required this.content,
    required this.createdAt,
  });
}

class ChatMessageReceiving extends ChatEvent {
  String roomId;
  String role;
  String content;
  String createdAt;

  ChatMessageReceiving({
    required this.roomId,
    required this.role,
    required this.content,
    required this.createdAt,
  });
}
