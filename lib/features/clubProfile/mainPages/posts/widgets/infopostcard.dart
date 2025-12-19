import 'package:akalpit/features/clubProfile/mainPages/posts/widgets/basecard.dart';
import 'package:akalpit/features/clubProfile/mainPages/posts/widgets/reactionsrow.dart';
import 'package:flutter/material.dart';

class InfoPostCard extends StatelessWidget {
  const InfoPostCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseCard(
      headerIcon: Icons.info_outline,
      title: "Did you know?",
      subtitle: "For subscribers",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "🎯 Volunteers will get certificates and priority access to future events.",
            style: TextStyle(fontSize: 14),
          ),
          const SizedBox(height: 12),
          ReactionRow(),
        ],
      ),
    );
  }
}
