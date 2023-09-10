abstract class ChatState {
  const ChatState();
}

class ChatInitial extends ChatState {
  const ChatInitial();
}

class ChatMessageSent extends ChatState {
  String roomId;
  String role;
  String content;
  String createdAt;

  ChatMessageSent({
    required this.roomId,
    required this.role,
    required this.content,
    required this.createdAt,
  });
}

class ChatMessageReceived extends ChatState {
  String role;
  String content;
  String roomId;
  String createdAt;

  ChatMessageReceived({
    required this.roomId,
    required this.role,
    required this.content,
    required this.createdAt,
  });
}
