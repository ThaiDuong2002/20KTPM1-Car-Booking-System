import 'dart:convert';

abstract class ChatEvent {}

class ChatEventSendMessage extends ChatEvent {
  String roomId;
  String role;
  String content;
  String createdAt;
  ChatEventSendMessage({
    required this.roomId,
    required this.role,
    required this.content,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'roomId': roomId});
    result.addAll({'role': role});
    result.addAll({'content': content});
    result.addAll({'createdAt': createdAt});
  
    return result;
  }

  factory ChatEventSendMessage.fromMap(Map<String, dynamic> map) {
    return ChatEventSendMessage(
      roomId: map['roomId'] ?? '',
      role: map['role'] ?? '',
      content: map['content'] ?? '',
      createdAt: map['createdAt'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatEventSendMessage.fromJson(String source) => ChatEventSendMessage.fromMap(json.decode(source));
}
class ChatEventReceiveMessage extends ChatEvent {
  final String message;

  ChatEventReceiveMessage(this.message);
}