import 'package:flutter/material.dart';

class HeadingContent {
  final String text;
  final int level;

  HeadingContent({required this.text, this.level = 1});

  factory HeadingContent.fromMap(Map<String, dynamic> map) {
    return HeadingContent(
      text: map['text'] ?? '',
      level: map['level'] ?? 1,
    );
  }
}

class HeadingStyle {
  final bool bold;
  final bool italic;
  final bool underline;

  HeadingStyle({this.bold = false, this.italic = false, this.underline = false});

  factory HeadingStyle.fromMap(Map<String, dynamic>? map) {
    if (map == null) return HeadingStyle();
    return HeadingStyle(
      bold: map['bold'] ?? false,
      italic: map['italic'] ?? false,
      underline: map['underline'] ?? false,
    );
  }
}

class HeadingBlockModel {
  final HeadingContent content;
  final HeadingStyle style;
  final String? color;
  final TextAlign align;
  final int order;

  HeadingBlockModel({
    required this.content,
    required this.style,
    this.color,
    this.align = TextAlign.left,
    required this.order,
  });

  factory HeadingBlockModel.fromMap(Map<String, dynamic> map) {
    // Color? parseColor(String? colorStr) {
    //   if (colorStr == null) return null;
    //   try {
    //     return Color(int.parse(colorStr));
    //   } catch (_) {
    //     return null;
    //   }
    // }

    return HeadingBlockModel(
      content: HeadingContent.fromMap(map['content'] ?? {}),
      style: HeadingStyle.fromMap(map['style']),
      color: map['color'],
      align: {
        'left': TextAlign.left,
        'center': TextAlign.center,
        'right': TextAlign.right,
      }[map['align']] ?? TextAlign.left,
      order: map['order'] ?? 0,
    );
  }
}
