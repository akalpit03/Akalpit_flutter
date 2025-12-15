import 'package:akalpit/features/posts/story/ui/supporter/list/models/list_block_model_widget.dart';
import 'package:flutter/material.dart';
 
class ListBlockWidget extends StatelessWidget {
  final ListBlockModel model;

  const ListBlockWidget({required this.model, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.only(left: 10),
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(
            color: Colors.white.withValues(alpha: 0.20),
            width: 2,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: model.items.asMap().entries.map((entry) {
          final index = entry.key;
          final item = entry.value;

          final bullet = model.ordered ? "${index + 1}." : "•";

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: SelectableText.rich(
              TextSpan(
                children: [
                  // Bullet
                  WidgetSpan(
                    alignment: PlaceholderAlignment.middle,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Text(
                        bullet,
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.80),
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),

                  // Main text
                  TextSpan(
                    text: item.text,
                    style: TextStyle(
                      fontSize: 16,
                      height: 1.45,
                      color: Colors.white.withValues(alpha: 0.92),
                      fontWeight: item.bold ? FontWeight.w700 : FontWeight.w400,
                      fontStyle:
                          item.italic ? FontStyle.italic : FontStyle.normal,
                      decoration: item.underline
                          ? TextDecoration.underline
                          : TextDecoration.none,
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
