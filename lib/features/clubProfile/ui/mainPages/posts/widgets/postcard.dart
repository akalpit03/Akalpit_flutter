import 'package:akalpit/features/clubProfile/ui/mainPages/posts/widgets/basecard.dart';
import 'package:akalpit/features/clubProfile/ui/mainPages/posts/widgets/reactionsrow.dart';
import 'package:flutter/material.dart';

class PostCard extends StatelessWidget {
  const PostCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseCard(
      headerIcon: Icons.post_add,
      title: "Akalpit Tech Club",
      subtitle: "2 hours ago",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "🚀 We are excited to announce our upcoming Hackathon this weekend!",
            style: TextStyle(fontSize: 14),
          ),
          const SizedBox(height: 12),
          ReactionRow(),
        ],
      ),
    );
  }
}
