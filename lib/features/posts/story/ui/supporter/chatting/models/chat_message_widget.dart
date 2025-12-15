class ChatMessage {
  final String sender;
  final String text;
  final String? timestamp;

  ChatMessage({
    required this.sender,
    required this.text,
    this.timestamp,
  });

  factory ChatMessage.fromMap(Map<String, dynamic> map) {
    return ChatMessage(
      sender: map['sender'] ?? '',
      text: map['text'] ?? '',
      timestamp: map['timestamp'],
    );
  }
}
