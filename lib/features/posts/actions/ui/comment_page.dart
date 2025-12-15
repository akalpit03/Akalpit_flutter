import 'dart:ui';
import 'package:flutter/material.dart';

class StoryCommentPage extends StatelessWidget {
  final String storyTitle;

  const StoryCommentPage({
    super.key,
    this.storyTitle = 'The Journey of Akalpit',
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0E0E0E),

      /// ================= AppBar =================
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Text(
          storyTitle,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),

      /// ================= Body =================
      body: Column(
        children: [
          /// ---------- Comments List ----------
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              itemCount: 10,
              separatorBuilder: (_, __) => const SizedBox(height: 14),
              itemBuilder: (_, index) {
                return const _CommentItem();
              },
            ),
          ),

          /// ---------- Comment Input ----------
          const _CommentInputBar(),
        ],
      ),
    );
  }
}

/// =======================================================
/// 🗨️ Single Comment Item (Glassy Card)
/// =======================================================
class _CommentItem extends StatelessWidget {
  const _CommentItem();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Profile Pic
        const CircleAvatar(
          radius: 18,
          backgroundImage: NetworkImage(
            'https://dummyimage.com/100x100/cccccc/000000&text=U',
          ),
        ),

        const SizedBox(width: 10),

        /// Comment Bubble
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.15),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    /// Username
                    Text(
                      'username_here',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),

                    SizedBox(height: 4),

                    /// Comment
                    Text(
                      'This is a dummy comment for the story. It can be multiline and simple text.',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.white70,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// =======================================================
/// ✍️ Bottom Comment Input Bar
/// =======================================================
class _CommentInputBar extends StatelessWidget {
  const _CommentInputBar();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        padding: const EdgeInsets.fromLTRB(12, 8, 12, 10),
        decoration: BoxDecoration(
          color: Colors.black,
          border: Border(
            top: BorderSide(
              color: Colors.white.withOpacity(0.08),
            ),
          ),
        ),
        child: Row(
          children: [
            /// Text Field
            Expanded(
              child: TextField(
                minLines: 1,
                maxLines: 4,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Write a comment...',
                  hintStyle: TextStyle(
                    color: Colors.white.withOpacity(0.4),
                  ),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.06),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 10,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),

            const SizedBox(width: 10),

            /// Send Button
            Container(
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: const Icon(
                  Icons.send_rounded,
                  color: Colors.white,
                  size: 20,
                ),
                onPressed: () {
                  // TODO: Send comment action
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
