import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

// ─────────────────────────────────────────────────────────────
// DUMMY COMMENTS
// ─────────────────────────────────────────────────────────────

final _dummyComments = [
  {
    'id': 'cm1',
    'username': 'abhay_2003',
    'avatar': 'https://res.cloudinary.com/du4hokehj/image/upload/v1767610396/uploads/uerkb5stpqginsbbb51b.png',
    'text': 'Really excited for this! Will the inter-department relay race be included this year?',
    'timeAgo': '1 hour ago',
    'likes': 12,
    'isLiked': false,
  },
  {
    'id': 'cm2',
    'username': 'priya_s',
    'avatar': 'https://res.cloudinary.com/du4hokehj/image/upload/v1767610396/uploads/uerkb5stpqginsbbb51b.png',
    'text': 'Can students from affiliated colleges also register?',
    'timeAgo': '45 min ago',
    'likes': 7,
    'isLiked': false,
  },
  {
    'id': 'cm3',
    'username': 'rahul_v',
    'avatar': 'https://res.cloudinary.com/du4hokehj/image/upload/v1767610396/uploads/uerkb5stpqginsbbb51b.png',
    'text': 'The sports complex renovation looks amazing. Looking forward to it 🙌',
    'timeAgo': '30 min ago',
    'likes': 19,
    'isLiked': true,
  },
];

// ─────────────────────────────────────────────────────────────
// POST DETAIL PAGE
// ─────────────────────────────────────────────────────────────

class PostDetailPage extends StatefulWidget {
  final Map<String, dynamic> post;

  const PostDetailPage({super.key, required this.post});

  @override
  State<PostDetailPage> createState() => _PostDetailPageState();
}

class _PostDetailPageState extends State<PostDetailPage> {
  late Map<String, dynamic> post;
  late List<Map<String, dynamic>> comments;
  final TextEditingController _commentController = TextEditingController();
  final FocusNode _commentFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    post = Map<String, dynamic>.from(widget.post);
    comments = _dummyComments
        .map((c) => Map<String, dynamic>.from(c))
        .toList();
  }

  @override
  void dispose() {
    _commentController.dispose();
    _commentFocus.dispose();
    super.dispose();
  }

  void _togglePostLike() {
    setState(() {
      final isLiked = post['isLiked'] as bool;
      post['isLiked'] = !isLiked;
      post['likes'] = (post['likes'] as int) + (isLiked ? -1 : 1);
    });
  }

  void _toggleCommentLike(int index) {
    setState(() {
      final isLiked = comments[index]['isLiked'] as bool;
      comments[index]['isLiked'] = !isLiked;
      comments[index]['likes'] =
          (comments[index]['likes'] as int) + (isLiked ? -1 : 1);
    });
  }

  void _submitComment() {
    final text = _commentController.text.trim();
    if (text.isEmpty) return;

    setState(() {
      comments.insert(0, {
        'id': 'cm_new_${DateTime.now().millisecondsSinceEpoch}',
        'username': 'you',
        'avatar': '',
        'text': text,
        'timeAgo': 'Just now',
        'likes': 0,
        'isLiked': false,
      });
      post['comments'] = (post['comments'] as int) + 1;
    });

    _commentController.clear();
    _commentFocus.unfocus();
    // TODO: wire comment API
  }

  String _fmt(int count) =>
      count >= 1000 ? '${(count / 1000).toStringAsFixed(1)}k' : '$count';

  @override
  Widget build(BuildContext context) {
    final isLiked = post['isLiked'] as bool;
    final hasImage = post['image'] != null;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),

      body: Column(
        children: [
          // ── Scrollable Content ─────────────────────────────
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              children: [
                // Institution header
                Row(
                  children: [
                    ClipOval(
                      child: CachedNetworkImage(
                        imageUrl: post['institutionLogo'],
                        height: 34,
                        width: 34,
                        fit: BoxFit.cover,
                        errorWidget: (_, __, ___) => Container(
                          height: 34,
                          width: 34,
                          color: const Color(0xFF2A2A2A),
                          child: const Icon(Icons.account_balance,
                              color: Colors.white24, size: 16),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          post['institutionName'],
                          style: const TextStyle(
                            color: Colors.white70,
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
                        ),
                        Text(
                          post['timeAgo'],
                          style: const TextStyle(
                              color: Colors.white38, fontSize: 11),
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 14),

                // Title
                Text(
                  post['title'],
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    height: 1.3,
                  ),
                ),

                const SizedBox(height: 14),

                // Optional image
                if (hasImage) ...[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: CachedNetworkImage(
                      imageUrl: post['image'],
                      width: double.infinity,
                      fit: BoxFit.cover,
                      placeholder: (_, __) => Container(
                        height: 200,
                        color: const Color(0xFF1A1A1A),
                        child: const Center(
                          child: CircularProgressIndicator(
                              color: Colors.white24, strokeWidth: 2),
                        ),
                      ),
                      errorWidget: (_, __, ___) => Container(
                        height: 200,
                        color: const Color(0xFF1A1A1A),
                        child: const Icon(Icons.image_outlined,
                            color: Colors.white12, size: 40),
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                ],

                // Full content
                Text(
                  post['content'],
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 15,
                    height: 1.7,
                  ),
                ),

                const SizedBox(height: 16),

                // Post actions
                Row(
                  children: [
                    _ActionBtn(
                      icon: isLiked
                          ? Icons.favorite_rounded
                          : Icons.favorite_border_rounded,
                      label: _fmt(post['likes'] as int),
                      color: isLiked ? Colors.redAccent : Colors.white38,
                      onTap: _togglePostLike,
                    ),
                    const SizedBox(width: 18),
                    _ActionBtn(
                      icon: Icons.mode_comment_outlined,
                      label: _fmt(post['comments'] as int),
                      color: Colors.white38,
                      onTap: () => _commentFocus.requestFocus(),
                    ),
                    const SizedBox(width: 18),
                    _ActionBtn(
                      icon: Icons.share_outlined,
                      label: _fmt(post['shares'] as int),
                      color: Colors.white38,
                      onTap: () {
                        // TODO: share
                      },
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // Comments header
                Divider(color: Colors.white.withOpacity(0.08), height: 1),
                const SizedBox(height: 16),

                Text(
                  '${post['comments']} Comments',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 14),

                // Comments list
                ...comments.asMap().entries.map((entry) {
                  final i = entry.key;
                  final comment = entry.value;
                  return _CommentTile(
                    comment: comment,
                    onLike: () => _toggleCommentLike(i),
                  );
                }),
              ],
            ),
          ),

          // ── Comment Input ──────────────────────────────────
          Container(
            padding: EdgeInsets.fromLTRB(
                16, 10, 16, MediaQuery.of(context).viewInsets.bottom + 12),
            decoration: BoxDecoration(
              color: const Color(0xFF111111),
              border: Border(
                  top: BorderSide(color: Colors.white.withOpacity(0.08))),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _commentController,
                    focusNode: _commentFocus,
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                    decoration: InputDecoration(
                      hintText: 'Write a comment...',
                      hintStyle: const TextStyle(
                          color: Colors.white38, fontSize: 14),
                      filled: true,
                      fillColor: const Color(0xFF1E1E1E),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 11),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: _submitComment,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.send_rounded,
                        color: Colors.black, size: 18),
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

// ─────────────────────────────────────────────────────────────
// COMMENT TILE
// ─────────────────────────────────────────────────────────────

class _CommentTile extends StatelessWidget {
  final Map<String, dynamic> comment;
  final VoidCallback onLike;

  const _CommentTile({required this.comment, required this.onLike});

  @override
  Widget build(BuildContext context) {
    final isLiked = comment['isLiked'] as bool;

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Avatar
          ClipOval(
            child: comment['avatar'] != ''
                ? CachedNetworkImage(
                    imageUrl: comment['avatar'],
                    height: 32,
                    width: 32,
                    fit: BoxFit.cover,
                    errorWidget: (_, __, ___) => _avatarFallback(),
                  )
                : _avatarFallback(),
          ),

          const SizedBox(width: 10),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Username + time
                Row(
                  children: [
                    Text(
                      '@${comment['username']}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      comment['timeAgo'],
                      style: const TextStyle(
                          color: Colors.white38, fontSize: 11),
                    ),
                  ],
                ),
                const SizedBox(height: 4),

                // Comment text
                Text(
                  comment['text'],
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 6),

                // Like action
                GestureDetector(
                  onTap: onLike,
                  child: Row(
                    children: [
                      Icon(
                        isLiked
                            ? Icons.favorite_rounded
                            : Icons.favorite_border_rounded,
                        color:
                            isLiked ? Colors.redAccent : Colors.white38,
                        size: 15,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${comment['likes']}',
                        style: TextStyle(
                          color: isLiked
                              ? Colors.redAccent
                              : Colors.white38,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _avatarFallback() {
    return Container(
      height: 32,
      width: 32,
      color: const Color(0xFF2A2A2A),
      child: const Icon(Icons.person, color: Colors.white24, size: 16),
    );
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
          Text(label, style: TextStyle(color: color, fontSize: 13)),
        ],
      ),
    );
  }
}