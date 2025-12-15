class ParagraphInlineModel {
  final String type; // text, highlight, link, mention
  final String text;
  final String? url;
  final String? topicId;
  final String? color;
  final bool bold;
  final bool italic;
  final bool underline;

  ParagraphInlineModel({
    required this.type,
    required this.text,
    this.url,
    this.topicId,
    this.color,
    this.bold = false,
    this.italic = false,
    this.underline = false,
  });

  factory ParagraphInlineModel.fromMap(Map<String, dynamic> map) {
    return ParagraphInlineModel(
      type: map['type'] ?? 'text',
      text: map['text'] ?? '',
      url: map['url'],
      topicId: map['topicId']?.toString(),
      color: map['color']?.toString(),
      bold: map['bold'] ?? false,
      italic: map['italic'] ?? false,
      underline: map['underline'] ?? false,
    );
  }
}

class ParagraphBlockModel {
  final List<ParagraphInlineModel> content;

  ParagraphBlockModel({required this.content});

  factory ParagraphBlockModel.fromMap(Map<String, dynamic> map) {
    final content = (map['content'] as List? ?? [])
        .map((item) => ParagraphInlineModel.fromMap(item))
        .toList();
    return ParagraphBlockModel(content: content);
  }
}
