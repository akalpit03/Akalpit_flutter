import 'package:akalpit/features/posts/story/ui/supporter/quote/models/quote_model_widget.dart';
import 'package:flutter/material.dart';
 
class QuoteBlockWidget extends StatelessWidget {
  final QuoteBlockModel model;

  const QuoteBlockWidget({required this.model, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 18),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.08),
          width: 1,
        ),
      ),

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Decorative left bar
          Container(
            width: 4,
            height: model.author != null ? 60 : 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              gradient: LinearGradient(
                colors: [
                  Colors.purpleAccent.withValues(alpha: 0.8),
                  Colors.blueAccent.withValues(alpha: 0.8),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),

          const SizedBox(width: 12),

          // Quote + Author
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Quote text
                Text(
                  '“${model.text}”',
                  style: TextStyle(
                    fontSize: 17,
                    height: 1.45,
                    color: Colors.white.withValues(alpha: 0.92),
                    fontWeight:
                        model.bold ? FontWeight.w700 : FontWeight.w500,
                    fontStyle:
                        model.italic ? FontStyle.italic : FontStyle.normal,
                    decoration: model.underline
                        ? TextDecoration.underline
                        : TextDecoration.none,
                  ),
                ),

                if (model.author != null && model.author!.trim().isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                      '— ${model.author}',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withValues(alpha: 0.55),
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
