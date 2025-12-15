import 'package:akalpit/features/posts/story/ui/supporter/sidenotes/models/sidenotes_model_widget.dart';
import 'package:flutter/material.dart';
 
class SidenoteBlockWidget extends StatelessWidget {
  final SidenoteBlockModel model;

  const SidenoteBlockWidget({required this.model, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isLeft = model.position == 'left';

    return Align(
      alignment: isLeft ? Alignment.centerLeft : Alignment.centerRight,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => _openFullNote(context),
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 6.0),
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.amber.shade100.withOpacity(0.8),
            borderRadius: BorderRadius.circular(12),
            border:
                Border.all(color: Colors.amber.shade700.withValues(alpha: 0.4)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (isLeft)
                const Icon(Icons.note_alt_outlined,
                    size: 20, color: Colors.black87),
              const SizedBox(width: 6),
              const Text(
                "Sidenote",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 6),
              if (!isLeft)
                const Icon(Icons.note_alt_outlined,
                    size: 20, color: Colors.black87),
            ],
          ),
        ),
      ),
    );
  }

  /// Open bottom sheet with full-width sidenote content
  void _openFullNote(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      showDragHandle: true,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model.text,
                style: const TextStyle(
                  fontSize: 16,
                  height: 1.5,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
