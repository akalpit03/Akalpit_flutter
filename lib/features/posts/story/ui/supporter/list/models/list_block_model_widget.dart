 

class ListItemModel {
  final String text;
  final bool bold;
  final bool italic;
  final bool underline;

  ListItemModel({
    required this.text,
    this.bold = false,
    this.italic = false,
    this.underline = false,
  });

  factory ListItemModel.fromMap(Map<String, dynamic> map) {
    final style = map['style'] ?? {};
    return ListItemModel(
      text: map['text'] ?? '',
      bold: style['bold'] ?? false,
      italic: style['italic'] ?? false,
      underline: style['underline'] ?? false,
    );
  }
}

class ListBlockModel {
  final bool ordered;
  final List<ListItemModel> items;
  final int order;

  ListBlockModel({
    required this.ordered,
    required this.items,
    required this.order,
  });

  factory ListBlockModel.fromMap(Map<String, dynamic> map) {
    final items = (map['items'] as List? ?? [])
        .map((item) => ListItemModel.fromMap(item))
        .toList();
    return ListBlockModel(
      ordered: map['ordered'] ?? false,
      items: items,
      order: map['order'] ?? 0,
    );
  }
}
