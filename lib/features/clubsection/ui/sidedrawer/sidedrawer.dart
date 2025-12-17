import 'package:flutter/material.dart';

class AppSideDrawer extends StatelessWidget {
  const AppSideDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            /// Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white24,
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  
                  SizedBox(height: 12),
                  Text(
                    'Activites for the clubs',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 4),
                  
                ],
              ),
            ),

            const SizedBox(height: 8),

            /// Drawer Items
            _DrawerItem(
              icon: Icons.volunteer_activism_outlined,
              title: 'Volunteering List',
              onTap: () {
                Navigator.pop(context);
              },
            ),

            _DrawerItem(
              icon: Icons.event_outlined,
              title: 'Upcoming Events',
              onTap: () {
                Navigator.pop(context);
              },
            ),

            _DrawerItem(
              icon: Icons.task_alt_outlined,
              title: 'My Tasks',
              onTap: () {
                Navigator.pop(context);
              },
            ),

            _DrawerItem(
              icon: Icons.more_horiz,
              title: 'Others',
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

/// Reusable Drawer Tile
class _DrawerItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final bool isDestructive;

  const _DrawerItem({
    required this.icon,
    required this.title,
    required this.onTap,
    this.isDestructive = false,
  });

  @override
  Widget build(BuildContext context) {
    final color = isDestructive ? Colors.red : Colors.white;

    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
          color: color,
        ),
      ),
      onTap: onTap,
      horizontalTitleGap: 12,
    );
  }
}
