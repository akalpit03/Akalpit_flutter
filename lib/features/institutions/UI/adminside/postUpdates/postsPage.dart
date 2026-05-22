import 'package:akalpit/features/institutions/UI/adminside/postUpdates/post_detail_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
 

// ─────────────────────────────────────────────────────────────
// DUMMY DATA
// ─────────────────────────────────────────────────────────────

final List<Map<String, dynamic>> dummyPosts = [
  {
    'id': 'p1',
    'institutionName': 'CSJMU University',
    'institutionLogo': 'https://res.cloudinary.com/du4hokehj/image/upload/v1767610396/uploads/uerkb5stpqginsbbb51b.png',
    'timeAgo': '2 hours ago',
    'title': 'Annual Sports Meet 2025 — Registration Now Open!',
    'content':
        'We are thrilled to announce that registrations for the Annual Sports Meet 2025 are now officially open. This year\'s event will feature over 20 sports categories including athletics, cricket, football, badminton, and many more.\n\nAll students are encouraged to participate and represent their departments. Registration forms are available at the Sports Complex front desk and online via the university portal.\n\nLast date to register: 20th March 2025.\n\nFor any queries, contact the Sports Council at sports@csjmu.ac.in',
    'image': 'https://res.cloudinary.com/du4hokehj/image/upload/v1767610396/uploads/uerkb5stpqginsbbb51b.png',
    'likes': 142,
    'comments': 38,
    'shares': 24,
    'isLiked': false,
  },
  {
    'id': 'p2',
    'institutionName': 'CSJMU University',
    'institutionLogo': 'https://res.cloudinary.com/du4hokehj/image/upload/v1767610396/uploads/uerkb5stpqginsbbb51b.png',
    'timeAgo': '1 day ago',
    'title': 'New Library Wing Inauguration — A Milestone for Students',
    'content':
        'The university is proud to announce the inauguration of the new east wing of the Central Library. The new wing houses over 50,000 new books, dedicated research cubicles, high-speed internet zones, and a 24/7 reading room for students.\n\nThe wing was inaugurated by the Vice Chancellor on 5th March 2025 in the presence of faculty, staff, and student representatives.\n\nStudents can access the new wing using their university ID cards starting from 10th March 2025.',
    'image': null,
    'likes': 89,
    'comments': 15,
    'shares': 31,
    'isLiked': true,
  },
  {
    'id': 'p3',
    'institutionName': 'CSJMU University',
    'institutionLogo': 'https://res.cloudinary.com/du4hokehj/image/upload/v1767610396/uploads/uerkb5stpqginsbbb51b.png',
    'timeAgo': '3 days ago',
    'title': 'Exam Schedule Released — Semester End Examinations',
    'content':
        'The examination cell has released the official schedule for semester-end examinations for all departments. Students are advised to download their admit cards from the official portal before the examination date.\n\nKey dates:\n- Form fill-up deadline: 15th March 2025\n- Admit card download: 20th March 2025\n- Examinations begin: 1st April 2025\n\nAny discrepancy in the schedule should be reported to the examination cell within 5 working days.',
    'image': 'https://res.cloudinary.com/du4hokehj/image/upload/v1767610396/uploads/uerkb5stpqginsbbb51b.png',
    'likes': 215,
    'comments': 67,
    'shares': 88,
    'isLiked': false,
  },
];

// ─────────────────────────────────────────────────────────────
// POSTS PAGE (shared — used by both user and admin)
// ─────────────────────────────────────────────────────────────

class PostsPage extends StatefulWidget {
  const PostsPage({super.key});

  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  late List<Map<String, dynamic>> posts;

  @override
  void initState() {
    super.initState();
    posts = List<Map<String, dynamic>>.from(
      dummyPosts.map((p) => Map<String, dynamic>.from(p)),
    );
  }

  void _toggleLike(int index) {
    setState(() {
      final post = posts[index];
      final isLiked = post['isLiked'] as bool;
      post['isLiked'] = !isLiked;
      post['likes'] = (post['likes'] as int) + (isLiked ? -1 : 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Posts',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: posts.length,
        separatorBuilder: (_, __) =>
            const Divider(color: Colors.white10, height: 1),
        itemBuilder: (context, index) {
          return PostCard(
            post: posts[index],
            onLike: () => _toggleLike(index),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => PostDetailPage(post: posts[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// POST CARD
// ─────────────────────────────────────────────────────────────

class PostCard extends StatelessWidget {
  final Map<String, dynamic> post;
  final VoidCallback onLike;
  final VoidCallback onTap;

  const PostCard({
    super.key,
    required this.post,
    required this.onLike,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isLiked = post['isLiked'] as bool;
    final hasImage = post['image'] != null;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Colors.black,
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Institution header ───────────────────────────
            Row(
              children: [
                ClipOval(
                  child: CachedNetworkImage(
                    imageUrl: post['institutionLogo'],
                    height: 32,
                    width: 32,
                    fit: BoxFit.cover,
                    errorWidget: (_, __, ___) => Container(
                      height: 32,
                      width: 32,
                      color: const Color(0xFF2A2A2A),
                      child: const Icon(Icons.account_balance,
                          color: Colors.white24, size: 16),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  post['institutionName'],
                  style: const TextStyle(
                    color: Colors.white70,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(width: 6),
                const Text('·',
                    style: TextStyle(color: Colors.white38, fontSize: 13)),
                const SizedBox(width: 6),
                Text(
                  post['timeAgo'],
                  style:
                      const TextStyle(color: Colors.white38, fontSize: 12),
                ),
              ],
            ),

            const SizedBox(height: 10),

            // ── Title ────────────────────────────────────────
            Text(
              post['title'],
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                height: 1.3,
              ),
            ),

            // ── Optional Image ───────────────────────────────
            if (hasImage) ...[
              const SizedBox(height: 12),
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: CachedNetworkImage(
                  imageUrl: post['image'],
                  width: double.infinity,
                  height: 180,
                  fit: BoxFit.cover,
                  placeholder: (_, __) => Container(
                    height: 180,
                    color: const Color(0xFF1A1A1A),
                    child: const Center(
                      child: CircularProgressIndicator(
                          color: Colors.white24, strokeWidth: 2),
                    ),
                  ),
                  errorWidget: (_, __, ___) => Container(
                    height: 180,
                    color: const Color(0xFF1A1A1A),
                    child: const Icon(Icons.image_outlined,
                        color: Colors.white12, size: 40),
                  ),
                ),
              ),
            ],

            const SizedBox(height: 12),

            // ── Actions ──────────────────────────────────────
            Row(
              children: [
                // Like
                _ActionBtn(
                  icon: isLiked
                      ? Icons.favorite_rounded
                      : Icons.favorite_border_rounded,
                  label: _formatCount(post['likes'] as int),
                  color: isLiked ? Colors.redAccent : Colors.white38,
                  onTap: onLike,
                ),
                const SizedBox(width: 18),

                // Comment
                _ActionBtn(
                  icon: Icons.mode_comment_outlined,
                  label: _formatCount(post['comments'] as int),
                  color: Colors.white38,
                  onTap: onTap,
                ),
                const SizedBox(width: 18),

                // Share
                _ActionBtn(
                  icon: Icons.share_outlined,
                  label: _formatCount(post['shares'] as int),
                  color: Colors.white38,
                  onTap: () {
                    // TODO: share
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatCount(int count) {
    if (count >= 1000) return '${(count / 1000).toStringAsFixed(1)}k';
    return '$count';
  }
}

// ─────────────────────────────────────────────────────────────
// ACTION BUTTON
// ─────────────────────────────────────────────────────────────

class _ActionBtn extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _ActionBtn({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 5),
          Text(
            label,
            style: TextStyle(color: color, fontSize: 13),
          ),
        ],
      ),
    );
  }
}