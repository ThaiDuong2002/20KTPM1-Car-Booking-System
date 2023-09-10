class ChatModel {
  static  List<Map<String, dynamic>> _messages = [];

  get messages => _messages;

  void addMessage(Map<String, dynamic> message) {
    _messages.add(message);
  }
}
