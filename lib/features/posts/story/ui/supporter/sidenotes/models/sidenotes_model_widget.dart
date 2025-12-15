 

class SidenoteBlockModel {
  final String text;
  final String position; // left or right
  final String? highlight;
  final int order;

  SidenoteBlockModel({
    required this.text,
    this.position = 'right',
    this.highlight,
    required this.order,
  });

  factory SidenoteBlockModel.fromMap(Map<String, dynamic> map) {
    return SidenoteBlockModel(
      text: map['text'] ?? '',
      position: map['position'] ?? 'right',
      highlight: map['highlight'],
      order: map['order'] ?? 0,
    );
  }
}
