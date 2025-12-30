import 'package:akalpit/core/constants/app_colors.dart';
import 'package:akalpit/features/clubProfile/ui/onboarding/screens/join/search_club_page.dart';
import 'package:akalpit/features/search/screens/clubSearch/clubSearch.dart';
import 'package:flutter/material.dart';

class ClubsAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ClubsAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0.5,

      /// Drawer icon
      leading: Builder(
        builder: (context) {
          return IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          );
        },
      ),

      /// Title
      title: const Text(
        'Clubs & Communities',
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),

      centerTitle: false,

      /// Actions
      actions: [
        /// Search bar
        IconButton(
  icon: const Icon(
    Icons.search,
    size: 22,
  ),
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const ClubSearchScreen(),
      ),
    );
  },
),

        const SizedBox(width: 8),

        /// More options
        PopupMenuButton<String>(
          icon: const Icon(Icons.more_vert),
          onSelected: (value) {
            switch (value) {
              case 'join':
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const SearchClubPage()),
                );
                break;

              case 'manage':
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (_) => const ManageCommunitiesPage()),
                // );
                break;

              case 'settings':
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (_) => const ClubSettingsPage()),
                // );
                break;
            }
          },
          itemBuilder: (context) => const [
            PopupMenuItem(
              value: 'join',
              child: Text('Join a Club'),
            ),
            PopupMenuItem(
              value: 'manage',
              child: Text('Manage Communities'),
            ),
            PopupMenuItem(
              value: 'settings',
              child: Text('Settings'),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

 

 
