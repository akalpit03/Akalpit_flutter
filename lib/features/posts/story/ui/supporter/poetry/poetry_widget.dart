import 'dart:ui';
import 'package:akalpit/features/posts/story/ui/supporter/poetry/models/poetry_block_model_widget.dart';
import 'package:flutter/material.dart';
 
class PoetryBlockWidget extends StatelessWidget {
  final PoetryBlockModel model;

  const PoetryBlockWidget({required this.model, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: 1),
      duration: const Duration(milliseconds: 500),
      builder: (context, opacity, _) {
        return Opacity(
          opacity: opacity,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.2),
                width: 0.8,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: model.lines.map((line) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: RichText(
                        text: TextSpan(
                          children: line.segments.map((segment) {
                            return TextSpan(
                              text: segment.text,
                              style: TextStyle(
                                fontSize: 16,
                                height: 1.6,
                                fontWeight:
                                    segment.bold ? FontWeight.w600 : FontWeight.w400,
                                fontStyle: segment.italic
                                    ? FontStyle.italic
                                    : FontStyle.normal,
                                decoration: segment.underline
                                    ? TextDecoration.underline
                                    : TextDecoration.none,
                                color: segment.color ?? Colors.white,
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
