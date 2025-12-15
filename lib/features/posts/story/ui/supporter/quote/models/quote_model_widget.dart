import 'package:flutter/material.dart';

class QuoteBlockModel {
  final String text;
  final String? author;
  final bool bold;
  final bool italic;
  final bool underline;
  final Color? color;
  final int order;

  QuoteBlockModel({
    required this.text,
    this.author,
    this.bold = false,
    this.italic = false,
    this.underline = false,
    this.color,
    required this.order,
  });

  factory QuoteBlockModel.fromMap(Map<String, dynamic> map) {
    Color? parseColor(String? colorStr) {
      if (colorStr == null) return null;
      try {
        return Color(int.parse(colorStr));
      } catch (_) {
        return null;
      }
    }

    final style = map['style'] ?? {};
    return QuoteBlockModel(
      text: map['text'] ?? '',
      author: map['author'],
      bold: style['bold'] ?? false,
      italic: style['italic'] ?? false,
      underline: style['underline'] ?? false,
      color: parseColor(style['color']),
      order: map['order'] ?? 0,
    );
  }
}
