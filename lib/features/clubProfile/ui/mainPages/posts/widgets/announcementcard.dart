import 'package:akalpit/features/clubProfile/services/models/post_data.dart';
import 'package:akalpit/features/clubProfile/ui/mainPages/posts/widgets/basecard.dart';
import 'package:akalpit/features/clubProfile/ui/mainPages/posts/widgets/reactionsrow.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AnnouncementCard extends StatelessWidget {
  final ClubPost post;

  const AnnouncementCard({
    super.key,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    return BaseCard(
      headerIcon: Icons.campaign,
      title: post.title,
      subtitle: _formatDate(post.createdAt),
      highlight: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            post.content,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          const ReactionRow(),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return DateFormat('dd MMM yyyy • hh:mm a').format(date);
  }
}
