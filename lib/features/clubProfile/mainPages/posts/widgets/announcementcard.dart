import 'package:akalpit/features/clubProfile/mainPages/posts/widgets/basecard.dart';
import 'package:akalpit/features/clubProfile/mainPages/posts/widgets/reactionsrow.dart';
import 'package:flutter/material.dart';

class AnnouncementCard extends StatelessWidget {
  const AnnouncementCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseCard(
      headerIcon: Icons.campaign,
      title: "Announcement",
      subtitle: "Important",
      highlight: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "📌 All participants must carry their college ID cards on event day.",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          ReactionRow(),
        ],
      ),
    );
  }
}
