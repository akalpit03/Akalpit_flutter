import 'dart:ui';
import 'package:akalpit/features/posts/story/ui/supporter/poetry/models/poetry_block_model_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
 
class PoetryBlockWidget extends StatefulWidget {
  final PoetryBlockModel model;

  const PoetryBlockWidget({required this.model, Key? key}) : super(key: key);

  @override
  State<PoetryBlockWidget> createState() => _PoetryBlockWidgetState();
}

class _PoetryBlockWidgetState extends State<PoetryBlockWidget> {
  /// Reader-controlled preference (UI only)
  TextAlign _alignment = TextAlign.left;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: const Duration(milliseconds: 450),
      builder: (context, opacity, _) {
        return Opacity(
          opacity: opacity,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 18),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.18),
                width: 0.8,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                child: Column(
                  crossAxisAlignment: _crossAxisForAlignment(_alignment),
                  children: [
                    _readerAlignmentControls(),
                    const SizedBox(height: 14),
                    ..._buildPoemLines(),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  // ─────────────────────────────────────────────
  // Reader Alignment Controls (UI-only)
  // ─────────────────────────────────────────────

  Widget _readerAlignmentControls() {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(12),
        ),
        child: ToggleButtons(
          borderRadius: BorderRadius.circular(10),
          constraints: const BoxConstraints(minWidth: 36, minHeight: 32),
          isSelected: [
            _alignment == TextAlign.left,
            _alignment == TextAlign.center,
            _alignment == TextAlign.right,
          ],
          onPressed: (index) {
            setState(() {
              _alignment = const [
                TextAlign.left,
                TextAlign.center,
                TextAlign.right,
              ][index];
            });
          },
          children: const [
            Icon(Icons.format_align_left, size: 18),
            Icon(Icons.format_align_center, size: 18),
            Icon(Icons.format_align_right, size: 18),
          ],
        ),
      ),
    );
  }

  // ─────────────────────────────────────────────
  // Poetry Rendering
  // ─────────────────────────────────────────────

  List<Widget> _buildPoemLines() {
    return widget.model.lines.map((line) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: RichText(
          textAlign: _alignment,
          text: TextSpan(
            children: _buildSegments(line.segments),
          ),
        ),
      );
    }).toList();
  }

  List<TextSpan> _buildSegments(List segments) {
    final List<TextSpan> spans = [];

    for (int i = 0; i < segments.length; i++) {
      final segment = segments[i];

      // Preserve spacing between segments
      if (i != 0 && !segment.text.startsWith(' ')) {
        spans.add(const TextSpan(text: ' '));
      }

      spans.add(
        TextSpan(
          text: segment.text.trimLeft(),
          style: GoogleFonts.notoSerifDevanagari(
            fontSize: 18,
            height: 1.9,
            letterSpacing: 0.25,
            wordSpacing: 1.2, // ✅ subtle space between words
            fontWeight:
                segment.bold ? FontWeight.w600 : FontWeight.w500,
            fontStyle:
                segment.italic ? FontStyle.italic : FontStyle.normal,
            decoration: segment.underline
                ? TextDecoration.underline
                : TextDecoration.none,
            color: segment.color ?? Colors.white,
          ),
        ),
      );
    }

    return spans;
  }

  // ─────────────────────────────────────────────
  // Alignment Mapping
  // ─────────────────────────────────────────────

  CrossAxisAlignment _crossAxisForAlignment(TextAlign align) {
    switch (align) {
      case TextAlign.center:
        return CrossAxisAlignment.center;
      case TextAlign.right:
        return CrossAxisAlignment.end;
      default:
        return CrossAxisAlignment.start;
    }
  }
}
