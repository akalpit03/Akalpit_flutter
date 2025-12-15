import 'package:flutter/material.dart';

class ProfileAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ProfileAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Builder(
        builder: (context) => IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
      ),
      title: const Text(
        'Profile Section',
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
      centerTitle: false,
      actions: [
        PopupMenuButton<String>(
          onSelected: (value) {
            // handle actions here
          },
          itemBuilder: (context) => const [
            PopupMenuItem(
              value: 'edit',
              child: Text('Edit Profile'),
            ),
            PopupMenuItem(
              value: 'privacy',
              child: Text('Privacy Settings'),
            ),
            PopupMenuItem(
              value: 'logout',
              child: Text('Logout'),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
