 import 'package:akalpit/features/clubProfile/services/states/clubs.dart';
import 'package:akalpit/features/clubProfile/ui/widgets/infoChip.dart';
import 'package:akalpit/features/clubProfile/ui/widgets/statuschip.dart';
import 'package:flutter/material.dart';

class ClubHeader extends StatelessWidget {
  final Club club;

  const ClubHeader({super.key, required this.club});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            theme.colorScheme.primary.withOpacity(0.12),
            Colors.grey.shade100,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: const BorderRadius.vertical(
          bottom: Radius.circular(28),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          /// ================= AVATAR =================
          Container(
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: theme.colorScheme.primary.withOpacity(0.4),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: CircleAvatar(
              radius: 34,
              backgroundColor: Colors.grey.shade300,
              backgroundImage:
                  club.image != null ? NetworkImage(club.image!) : null,
              child: club.image == null
                  ? Icon(
                      Icons.groups,
                      size: 30,
                      color: theme.colorScheme.primary,
                    )
                  : null,
            ),
          ),

          const SizedBox(width: 16),

          /// ================= INFO =================
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Club Name
                Text(
                  club.clubName,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),

                const SizedBox(height: 10),

                /// Meta Info Row
                Row(
                  children: [
                    InfoChip(
                      icon: Icons.group,
                      label: "${club.membersCount} Members",
                    ),
                    const SizedBox(width: 8),
                    StatusChip(status: club.status),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
