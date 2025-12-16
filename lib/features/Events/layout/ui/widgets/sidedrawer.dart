import 'package:flutter/material.dart';

class EventSideDrawer extends StatelessWidget {
  const EventSideDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              color: Colors.blueGrey,
              child: const Text(
                'Event Menu',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),

            const SizedBox(height: 8),

            _DrawerItem(icon: Icons.emoji_events_outlined, title: 'Competitions', onTap: () => Navigator.pop(context)),
            _DrawerItem(icon: Icons.how_to_reg_outlined, title: 'Participation', onTap: () => Navigator.pop(context)),
            _DrawerItem(icon: Icons.event_outlined, title: 'Events', onTap: () => Navigator.pop(context)),
            _DrawerItem(icon: Icons.more_horiz, title: 'Others', onTap: () => Navigator.pop(context)),

            const Spacer(),
          ],
        ),
      ),
    );
  }
}

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
      leading: Icon(icon, color: Colors.white),
      title: Text(
        title,
        style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500),
      ),
      onTap: onTap,
    );
  }
}
