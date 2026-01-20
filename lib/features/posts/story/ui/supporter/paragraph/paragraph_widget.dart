import 'package:akalpit/features/posts/story/ui/supporter/paragraph/models/paragraph_model_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
 
 
class ParagraphBlockWidget extends StatelessWidget {
  final ParagraphBlockModel model;

  const ParagraphBlockWidget({
    required this.model,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 6.0,
        horizontal: 4.0,
      ),
      child: SelectableText.rich(
        TextSpan(
          children: model.content.map((segment) {
            return _buildInlineSpan(context, segment);
          }).toList(),
        ),
        textAlign: TextAlign.start,
        scrollPhysics: const NeverScrollableScrollPhysics(),
      ),
    );
  }

  TextSpan _buildInlineSpan(
    BuildContext context,
    ParagraphInlineModel segment,
  ) {
    TextStyle style = GoogleFonts.merriweather(
      fontSize: 16.5,
      height: 1.7,
      wordSpacing: 1.0,
      letterSpacing: 0.2,
      color: Colors.white.withValues(alpha: 0.92),
      fontWeight: segment.bold ? FontWeight.w600 : FontWeight.w400,
      fontStyle: segment.italic ? FontStyle.italic : FontStyle.normal,
      decoration:
          segment.underline ? TextDecoration.underline : TextDecoration.none,
    );

    // Highlight text
    if (segment.type == "highlight") {
      style = style.copyWith(
        backgroundColor:
            _parseColor(segment.color) ?? _parseColor("#ababab"),
        color: Colors.black,
      );
    }

    // Link text
    if (segment.type == "link" && segment.url != null) {
      return TextSpan(
        text: segment.text,
        style: style.copyWith(
          color: const Color.fromARGB(255, 115, 153, 219),
          decoration: TextDecoration.underline,
        ),
        recognizer: TapGestureRecognizer()
          ..onTap = () {
            _openLink(segment.url!);
          },
      );
    }

    // Mention text
    if (segment.type == "mention" && segment.topicId != null) {
      return TextSpan(
        text: segment.text,
        style: style.copyWith(
          color: Colors.tealAccent,
          fontWeight: FontWeight.w600,
        ),
        recognizer: TapGestureRecognizer()
          ..onTap = () {
            debugPrint("Mention clicked: ${segment.topicId}");
          },
      );
    }

    // Default plain text
    return TextSpan(
      text: segment.text,
      style: style,
    );
  }
}

Color _parseColor(String? hex) {
  try {
    if (hex != null && hex.startsWith('#')) {
      return Color(
        int.parse(hex.substring(1), radix: 16) + 0xFF000000,
      );
    } else {
      return Colors.black;
    }
  } catch (_) {
    return Colors.black;
  }
}

void _openLink(String url) async {
  final uri = Uri.parse(url);

  if (await canLaunchUrl(uri)) {
    await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    );
  } else {
    debugPrint("Could not launch $url");
  }
}
