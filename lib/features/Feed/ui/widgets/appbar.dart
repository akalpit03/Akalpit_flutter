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
          onPressed: () {},
        ),

        /// Notifications
        IconButton(
          icon: const Icon(Icons.notifications_none),
          onPressed: () {},
        ),

        const SizedBox(width: 8),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
