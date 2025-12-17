import 'package:flutter/material.dart';

class ChatCard extends StatelessWidget {
  final String name;
  final int unreadCount;

  const ChatCard({
    super.key,
    required this.name,
    required this.unreadCount,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [
          /// DP
          CircleAvatar(
            radius: 26,
            backgroundColor: Colors.grey.shade300,
            child: const Icon(Icons.person, color: Colors.white),
          ),

          const SizedBox(width: 14),

          /// Name
          Expanded(
            child: Text(
              name,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          /// Unread Counter
          if (unreadCount > 0)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                unreadCount.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
