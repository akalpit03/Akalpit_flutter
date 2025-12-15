import 'package:akalpit/features/posts/story/ui/supporter/heading/models/heading_style_model_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:penverse/core/constants/constants.dart';
  

class HeadingBlockWidget extends StatelessWidget {
  final HeadingBlockModel model;

  const HeadingBlockWidget({required this.model, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Determine font size based on heading level
    double fontSize;
    switch (model.content.level) {
      case 1:
        fontSize = 32;
        break;
      case 2:
        fontSize = 28;
        break;
      case 3:
        fontSize = 24;
        break;
      case 4:
        fontSize = 20;
        break;
      case 5:
        fontSize = 18;
        break;
      default:
        fontSize = 16;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Container(
        
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
        child: Text(
          model.content.text,
          textAlign: model.align,
          style: GoogleFonts.lato(
            fontSize: fontSize,
            fontWeight: model.style.bold ? FontWeight.bold : FontWeight.w600,
            fontStyle: model.style.italic ? FontStyle.italic : FontStyle.normal,
            decoration:
                model.style.underline ? TextDecoration.underline : TextDecoration.none,
            color: _parseColor(model.color),
            shadows: [
              const Shadow(
                color: Colors.black12,
                offset: Offset(1, 1),
                blurRadius: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Utility to convert hex color string to Color
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
