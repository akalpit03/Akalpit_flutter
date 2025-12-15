import 'package:akalpit/features/posts/story/ui/supporter/chatting/models/chat_message_widget.dart';
 

class ChatBlockModel {
    final bool isChatting;
  final List<ChatMessage> messages;
  final int order;

  ChatBlockModel({required this.isChatting, required this.messages, required this.order});
  factory ChatBlockModel.fromMap(Map<String, dynamic> map) {
    List<ChatMessage> messages = [];
    if (map['messages'] != null) {
      messages = (map['messages'] as List)
          .map((msg) => ChatMessage.fromMap(msg))
          .toList();
    }
    return ChatBlockModel(
      isChatting: map['isChatting'] ?? false,
      messages: messages,
      order: map['order'] ?? 0,
    );
  }
}
