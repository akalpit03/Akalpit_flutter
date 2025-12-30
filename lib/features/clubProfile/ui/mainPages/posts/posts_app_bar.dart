 import 'package:akalpit/features/clubProfile/services/utils/roleenum.dart';
import 'package:akalpit/features/clubProfile/ui/single_club_profile.dart';
import 'package:flutter/material.dart';
import '../../miscellaneous/settings_screen.dart';

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

  void _onTitleTap(BuildContext context) {
    // 🔁 Replace with your destination page later
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const ClubProfilePage(
          isGuest: false,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      title: InkWell(
        onTap: () => _onTitleTap(context),
        borderRadius: BorderRadius.circular(8),
        child: Row(
          children: [
            const SizedBox(width: 16),
            CircleAvatar(
              radius: 25,
              backgroundImage: NetworkImage(imageUrl),
              backgroundColor: Colors.grey.shade300,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                clubTitle,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        if (role == ClubRole.admin)
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert),
            onSelected: (value) {
              switch (value) {
                case 'edit':
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (_) => const EditClubPage(),
                  //   ),
                  // );
                  break;

                case 'settings':
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const ClubSettingsPage(),
                    ),
                  );
                  break;
              }
            },
            itemBuilder: (_) => const [
              PopupMenuItem(
                value: 'edit',
                child: Text("Edit Club"),
              ),
              PopupMenuItem(
                value: 'settings',
                child: Text("Settings"),
              ),
            ],
          ),
      ],
      bottom: bottom,
      elevation: 0,
    );
  }
}
