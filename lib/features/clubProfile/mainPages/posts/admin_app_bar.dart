import 'package:akalpit/features/clubProfile/mainPages/posts/services/role.dart';
import 'package:flutter/material.dart';

class ClubAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String clubTitle;
  final String imageUrl;
  final ClubRole role;
  final PreferredSizeWidget? bottom;

  const ClubAppBar({
    super.key,
    required this.clubTitle,
    required this.imageUrl,
    required this.role,
    this.bottom,
  });

  @override
  Size get preferredSize =>
      Size.fromHeight(kToolbarHeight + (bottom?.preferredSize.height ?? 0));

  @override
  Widget build(BuildContext context) {
    return AppBar(
      titleSpacing: 0,
      title: Row(
        children: [
          const SizedBox(width: 12),
          CircleAvatar(
            radius: 18,
            backgroundImage: NetworkImage(imageUrl),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              clubTitle,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
      actions: [
        if (role == ClubRole.admin)
          PopupMenuButton<String>(
            itemBuilder: (_) => const [
              PopupMenuItem(value: 'edit', child: Text("Edit Club")),
              PopupMenuItem(value: 'settings', child: Text("Settings")),
            ],
          ),
      ],
      bottom: bottom,
    );
  }
}
