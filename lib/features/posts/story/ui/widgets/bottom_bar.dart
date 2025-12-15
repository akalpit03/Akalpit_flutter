import 'package:akalpit/features/posts/actions/ui/comment_page.dart';
import 'package:flutter/material.dart';

class StoryBottomBar extends StatelessWidget {
  const StoryBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.9),
        border: Border(
          top: BorderSide(color: Colors.white.withOpacity(0.1)),
        ),
      ),
      child: Row(
        children: [
          /// Profile Pic
          const CircleAvatar(
            radius: 18,
            backgroundImage:
                NetworkImage('https://dummyimage.com/100x100/aaaaaa/000000'),
          ),
          const SizedBox(width: 8),

          /// Username
          const Text(
            'akalpit_user',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),

          const Spacer(),

          _ActionItem(
            icon: Icons.favorite_border,
            count: '24',
            onTap: () {},
          ),
          _ActionItem(
            icon: Icons.comment_outlined,
            count: '8',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => const StoryCommentPage(
                        storyTitle: "the title for the comment page")),
              );
            },
          ),
          _ActionItem(
            icon: Icons.share_outlined,
            count: '5',
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

class _ActionItem extends StatelessWidget {
  final IconData icon;
  final String count;
  final VoidCallback onTap;

  const _ActionItem({
    required this.icon,
    required this.count,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Row(
          children: [
            Icon(icon, size: 18, color: Colors.white70),
            const SizedBox(width: 4),
            Text(
              count,
              style: const TextStyle(color: Colors.white70, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
