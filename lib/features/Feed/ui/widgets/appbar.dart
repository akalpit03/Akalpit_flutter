import 'package:akalpit/features/Feed/ui/notification.dart';
import 'package:akalpit/features/search/screens/profilesearch/searchScreen.dart';
import 'package:flutter/material.dart';

class FeedAppBar extends StatelessWidget implements PreferredSizeWidget {
  const FeedAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
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
      title: const Text(
        'AKALPIT',
        style: TextStyle(
          fontWeight: FontWeight.w600,
          letterSpacing: 1.1,
        ),
      ),
      centerTitle: true,
      actions: [
        /// Search
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => const ProfileSearchScreen(),
              ),
            );
          },
        ),
// NotificationPage
        /// Notifications
        IconButton(
          icon: const Icon(Icons.notifications_none),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => const NotificationPage(),
              ),
            );
          },
        ),

        /// Settings (NEW)
        IconButton(
          icon: const Icon(Icons.settings_outlined),
          onPressed: () {}, // leave function blank for now
        ),

        const SizedBox(width: 8),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
