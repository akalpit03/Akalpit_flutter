import 'package:akalpit/features/posts/story/ui/supporter/divider/models/divider_block_model.dart';
import 'package:flutter/material.dart';
  

class DividerBlockWidget extends StatelessWidget {
  final DividerBlockModel model;

  const DividerBlockWidget({required this.model, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // For simplicity, dashed/dotted can be handled with a basic Container and decoration
    Widget dividerLine;
    switch (model.style) {
      case 'dashed':
        dividerLine = LayoutBuilder(
          builder: (context, constraints) {
            const dashWidth = 5.0;
            const dashSpace = 5.0;
            final dashCount = (constraints.maxWidth / (dashWidth + dashSpace)).floor();
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                dashCount,
                (_) => Container(
                  width: dashWidth,
                  height: model.thickness ?? 2,
                  color:_parseColor(model.color) ?? Colors.grey,
                ),
              ),
            );
          },
        );
        break;
      case 'dotted':
        dividerLine = LayoutBuilder(
          builder: (context, constraints) {
            final dotSize = model.thickness ?? 2.0;
            final spacing = dotSize * 2;
            final dotCount = (constraints.maxWidth / spacing).floor();
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                dotCount,
                (_) => Container(
                  width: dotSize,
                  height: dotSize,
                  decoration: BoxDecoration(
                    color: _parseColor(model.color) ?? Colors.grey,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            );
          },
        );
        break;
      default:
        dividerLine = Container(
          height: model.thickness ?? 2,
          color: _parseColor(model.color) ?? Colors.grey,
        );
    }

    return Padding(
      padding: EdgeInsets.only(
        top: model.marginTop ?? 8.0,
        bottom: model.marginBottom ?? 8.0,
      ),
      child: dividerLine,
    );
  }
}
Color _parseColor(String? hex) {
    try {
      if (hex != null && hex.startsWith('#')) {
        return Color(int.parse(hex.substring(1), radix: 16) + 0xFF000000);
      } else {
        return Colors.black;
      }
    } catch (_) {
      return Colors.black;
    }
  }