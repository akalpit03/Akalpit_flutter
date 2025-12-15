import 'dart:ui';
import 'package:flutter/material.dart';

class FeedCard extends StatelessWidget {
  final bool hasImage;

  const FeedCard({
    super.key,
    this.hasImage = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.04),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: Colors.white.withOpacity(0.08),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Header
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 16,
                        backgroundColor: Colors.grey.shade400,
                        child: const Icon(Icons.person, size: 18),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'username_here',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        '2h ago',
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ],
                  ),
                ),

                /// Title

                /// Optional Image
                if (hasImage)
                  Container(
                    height: 400,
                    margin: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.grey.shade300,
                    ),
                    child: const Center(
                      child: Icon(Icons.image, size: 60, color: Colors.white),
                    ),
                  ),

                const SizedBox(height: 12),
                const SizedBox(height: 10),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    'This is a Sample Card for style feed title which can have either image or just text content inside it.',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      height: 1.3,
                    ),
                  ),
                ),

                /// Actions (slightly separated)
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: Row(
                    children: [
                      const _ModernActionItem(
                        icon: Icons.favorite_border,
                        label: '24',
                      ),
                      const SizedBox(width: 14),
                     const _ModernActionItem(
                        icon: Icons.comment_outlined,
                        label: '8',
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Row(
                          children:   [
                            Icon(
                              Icons.visibility_outlined,
                              size: 16,
                              color: Colors.grey,
                            ),
                            SizedBox(width: 6),
                            Text(
                              '120',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ModernActionItem extends StatelessWidget {
  final IconData icon;
  final String label;

  const _ModernActionItem({
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.grey.withAlpha(112),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 16,
            color: Colors.grey.shade700,
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

 