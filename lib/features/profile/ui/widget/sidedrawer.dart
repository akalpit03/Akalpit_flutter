import 'package:akalpit/features/profile/ui/friendslist.dart';
import 'package:akalpit/features/profile/ui/requests/incomingrequests.dart';
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

          
            _DrawerItem(
              icon: Icons.group_outlined,
              title: 'My Friends',
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const FriendsPage( ),
                  ),
                );
              },
            ),

            /// 🔥 Incoming Friend Requests
            _DrawerItem(
              icon: Icons.person_add_alt_1_outlined,
              title: 'Incoming Requests',
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        const FriendsIncomingRequestsPage(),
                  ),
                );
              },
            ),

            _DrawerItem(
              icon: Icons.emoji_events_outlined,
              title: 'My Awards',
              onTap: () {
                Navigator.pop(context);
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (_) => const MyAwardsPage(),
                //   ),
                // );
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
