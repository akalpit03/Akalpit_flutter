import 'package:akalpit/features/posts/story/ui/supporter/timeliner/models/timeline_event_model_widget.dart';
import 'package:flutter/material.dart';
 
class TimelineBlockWidget extends StatelessWidget {
  final TimelineBlockModel model;

  const TimelineBlockWidget({required this.model, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: model.events.asMap().entries.map((entry) {
        final index = entry.key;
        final event = entry.value;

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // LEFT TIMELINE
            Column(
              children: [
                // glowing circle
                Container(
                  width: 14,
                  height: 14,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [
                          Colors.blueAccent.withValues(alpha: 0.4),
                          Colors.tealAccent.withValues(alpha: 0.4),
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.tealAccent.withValues(alpha: 0.4),
                        blurRadius: 12,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                ),

                // vertical connector (only if not last)
                if (index != model.events.length - 1)
                  Container(
                    width: 2,
                    height: 75,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.blueAccent.withValues(alpha: 0.4),
                          Colors.tealAccent.withValues(alpha: 0.4),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
              ],
            ),

            const SizedBox(width: 14),

            // RIGHT CONTENT WITH MODERN CARD
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(bottom: 20),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.08),
                    width: 1,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                      event.title,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: Colors.white.withValues(alpha: 0.95),
                      ),
                    ),

                    if (event.description != null &&
                        event.description!.trim().isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 6),
                        child: Text(
                          event.description!,
                          style: TextStyle(
                            fontSize: 15,
                            height: 1.45,
                            color: Colors.white.withValues(alpha: 0.8),
                          ),
                        ),
                      ),

                    if (event.date != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text(
                          _formatDate(event.date!),
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white.withValues(alpha: 0.55),
                          ),
                        ),
                      ),

                    if (event.image != null &&
                        event.image!.trim().isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(event.image!),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        );
      }).toList(),
    );
  }

  String _formatDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year}";
  }
}
