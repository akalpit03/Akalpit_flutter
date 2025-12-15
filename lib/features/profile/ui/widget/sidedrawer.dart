import 'package:flutter/material.dart';

class ProfileSideDrawer extends StatelessWidget {
  const ProfileSideDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ===== Header =====
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              child: const Text(
                'Profile Actions',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            const Divider(),

            // ===== Drawer Items =====
            _DrawerItem(
              icon: Icons.people_outline,
              title: 'My Followings',
              onTap: () {
                Navigator.pop(context);
              },
            ),

            _DrawerItem(
              icon: Icons.group_outlined,
              title: 'My Friends',
              onTap: () {
                Navigator.pop(context);
              },
            ),

            _DrawerItem(
              icon: Icons.emoji_events_outlined,
              title: 'My Awards',
              onTap: () {
                Navigator.pop(context);
              },
            ),

            const Spacer(),
            const Divider(),
          ],
        ),
      ),
    );
  }
}

// ===== Reusable Drawer Tile =====
class _DrawerItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _DrawerItem({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: onTap,
    );
  }
}
