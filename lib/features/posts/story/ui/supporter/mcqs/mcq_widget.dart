import 'package:akalpit/core/constants/app_colors.dart';
import 'package:akalpit/features/posts/story/ui/supporter/mcqs/models/mcq_block_model_widget.dart';
import 'package:flutter/material.dart';
  
class MCQBlockWidget extends StatefulWidget {
  final MCQBlockModel model;

  const MCQBlockWidget({required this.model, Key? key}) : super(key: key);

  @override
  State<MCQBlockWidget> createState() => _MCQBlockWidgetState();
}

class _MCQBlockWidgetState extends State<MCQBlockWidget> {
  int? selectedIndex; // User-selected option
  bool answered = false; // Whether user has clicked

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.scaffoldBackground,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 2),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// --- Question ---
          Text(
            widget.model.question,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),

          const SizedBox(height: 16),

          /// ---- Options ----
          Column(
            children: widget.model.options.asMap().entries.map((entry) {
              final index = entry.key;
              final option = entry.value;

              /// Determine color states
              bool isCorrect =  widget.model.correctOption != null && index == widget.model.correctOption;
              bool isSelected = selectedIndex == index;

              Color tileColor = Colors.grey.shade100;
              Color borderColor = Colors.transparent;

              if (answered) {
                if (isSelected && isCorrect) {
                  tileColor = Colors.green.shade100;
                  borderColor = Colors.green;
                } else if (isSelected && !isCorrect) {
                  tileColor = Colors.red.shade100;
                  borderColor = Colors.red;
                } else if (isCorrect) {
                  tileColor = Colors.green.shade50;
                  borderColor = Colors.green;
                }
              }

              return Container(
                margin: const EdgeInsets.only(bottom: 10),
                child: Material(
                  color: AppColors.cardBackground,
                  borderRadius: BorderRadius.circular(12),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: answered
                        ? null
                        : () {
                            setState(() {
                              selectedIndex = index;
                              answered = true;
                            });
                          },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: borderColor, width: 2),
                      ),
                      padding: const EdgeInsets.all(14),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// Index number bubble
                          CircleAvatar(
                            radius: 14,
                            backgroundColor: Colors.blue.shade100,
                            child: Text(
                              "${index + 1}",
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),

                          const SizedBox(width: 12),

                          /// Option text
                          Expanded(
                            child: Text(
                              option.text,
                              style: const TextStyle(fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),

          /// ------- Explanation (visible only after answering) -------
          if (answered && widget.model.explanation != null) ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                "💡 Explanation: ${widget.model.explanation}",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.blue.shade900,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
