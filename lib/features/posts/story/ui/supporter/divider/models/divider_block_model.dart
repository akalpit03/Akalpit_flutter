import 'package:flutter/material.dart';

class DividerBlockModel {
  final String style; // "solid", "dashed", "dotted"
  final double? thickness;
  final String? color;
  final double? marginTop;
  final double? marginBottom;
  final int order;

  DividerBlockModel({
    required this.style,
    this.thickness,
    this.color,
    this.marginTop,
    this.marginBottom,
    required this.order,
  });

  factory DividerBlockModel.fromMap(Map<String, dynamic> map) {
    Color? parseColor(String? colorStr) {
      if (colorStr == null) return null;
      try {
        return Color(int.parse(colorStr));
      } catch (e) {
        return null;
      }
    }

    return DividerBlockModel(
      style: map['style'] ?? 'solid',
      thickness: map['thickness']?.toDouble(),
      color:  map['color'],
      marginTop: map['marginTop']?.toDouble(),
      marginBottom: map['marginBottom']?.toDouble(),
      order: map['order'] ?? 0,
    );
  }
}
