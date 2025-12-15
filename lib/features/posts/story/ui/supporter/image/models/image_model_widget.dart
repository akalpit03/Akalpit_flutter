import 'package:flutter/material.dart';

class ImageBlockModel {
  final String url;
  final String? caption;
  final String? alt;
  final double? width;
  final double? height;
  final Alignment alignment;
  final int order;

  ImageBlockModel({
    required this.url,
    this.caption,
    this.alt,
    this.width,
    this.height,
    required this.alignment,
    required this.order,
  });

  factory ImageBlockModel.fromMap(Map<String, dynamic> map) {
    Alignment parseAlign(String? align) {
      switch (align) {
        case 'left':
          return Alignment.centerLeft;
        case 'right':
          return Alignment.centerRight;
        default:
          return Alignment.center;
      }
    }

    return ImageBlockModel(
      url: map['url'] ?? '',
      caption: map['caption'],
      alt: map['alt'],
      width: map['width']?.toDouble(),
      height: map['height']?.toDouble(),
      alignment: parseAlign(map['align']),
      order: map['order'] ?? 0,
    );
  }
}
