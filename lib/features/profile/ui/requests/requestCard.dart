import 'package:akalpit/features/profile/services/models/incomoingRequests/request.dart';
import 'package:flutter/material.dart';

class FriendRequestCard extends StatelessWidget {
  final IncomingRequest request;
  final VoidCallback onProfileTap;
  final VoidCallback onAccept;
  final VoidCallback onReject;

  const FriendRequestCard({
    required this.request,
    required this.onProfileTap,
    required this.onAccept,
    required this.onReject,
  });

  @override
  Widget build(BuildContext context) {
    final username = request.requester.username; // Replace if username exists
    final requestedAt = request.createdAt.toIso8601String();

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            GestureDetector(
              onTap: onProfileTap,
              child: CircleAvatar(
                radius: 26,
                backgroundColor: Colors.blueGrey.shade100,
                backgroundImage: request.requester.imageUrl.isNotEmpty
                    ? NetworkImage(request.requester.imageUrl)
                    : null,
                child: request.requester.imageUrl.isEmpty
                    ? const Icon(Icons.person, color: Colors.blueGrey)
                    : null,
              ),
            ),

            const SizedBox(width: 14),

            Expanded(
              child: InkWell(
                onTap: onProfileTap,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      username!,
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Requested on ${requestedAt.split('T')[0]}",
                      style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey.shade600),
                    ),
                  ],
                ),
              ),
            ),

            Column(
              children: [
                _ActionButton(
                    label: "Accept",
                    color: Colors.green,
                    onTap: onAccept),
                const SizedBox(height: 6),
                _ActionButton(
                    label: "Reject",
                    color: Colors.red,
                    onTap: onReject),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
class _ActionButton extends StatelessWidget {
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _ActionButton(
      {required this.label, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          border: Border.all(color: color),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          label,
          style: TextStyle(
              fontSize: 13, fontWeight: FontWeight.w600, color: color),
        ),
      ),
    );
  }
}
