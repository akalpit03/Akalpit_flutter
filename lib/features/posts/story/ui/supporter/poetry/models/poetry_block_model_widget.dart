import 'package:flutter/material.dart';

class PoetryInlineModel {
  final String text;
  final bool bold;
  final bool italic;
  final bool underline;
  final Color? color;

  PoetryInlineModel({
    required this.text,
    this.bold = false,
    this.italic = false,
    this.underline = false,
    this.color,
  });

  factory PoetryInlineModel.fromMap(Map<String, dynamic> map) {
    Color? parseColor(String? colorStr) {
      if (colorStr == null) return null;
      try {
        return Color(int.parse(colorStr));
      } catch (_) {
        return null;
      }
    }

    final style = map['style'] ?? {};
    return PoetryInlineModel(
      text: map['text'] ?? '',
      bold: style['bold'] ?? false,
      italic: style['italic'] ?? false,
      underline: style['underline'] ?? false,
      color: parseColor(style['color']),
    );
  }
}

class PoetryLineModel {
  final List<PoetryInlineModel> segments;

  PoetryLineModel({required this.segments});

  factory PoetryLineModel.fromMap(Map<String, dynamic> map) {
    final segments = (map['segments'] as List? ?? [])
        .map((s) => PoetryInlineModel.fromMap(s))
        .toList();
    return PoetryLineModel(segments: segments);
  }
}

class PoetryBlockModel {
  final List<PoetryLineModel> lines;
  final int order;

  PoetryBlockModel({required this.lines, required this.order});

  factory PoetryBlockModel.fromMap(Map<String, dynamic> map) {
    final lines = (map['lines'] as List? ?? [])
        .map((line) => PoetryLineModel.fromMap(line))
        .toList();
    return PoetryBlockModel(
      lines: lines,
      order: map['order'] ?? 0,
    );
  }
}
