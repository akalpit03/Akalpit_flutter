import 'package:flutter/material.dart';

class ServicesSideDrawer extends StatelessWidget {
  const ServicesSideDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.black,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.grey.shade900,
              ),
              child: const Text(
                'Services Menu',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),

            const SizedBox(height: 8),

            /// Drawer Items
            _DrawerItem(
              icon: Icons.category_outlined,
              title: 'All Categories',
              onTap: () => Navigator.pop(context),
            ),
            _DrawerItem(
              icon: Icons.school_outlined,
              title: 'Education',
              onTap: () => Navigator.pop(context),
            ),
            _DrawerItem(
              icon: Icons.restaurant_outlined,
              title: 'Food & Restaurants',
              onTap: () => Navigator.pop(context),
            ),
            _DrawerItem(
              icon: Icons.home_repair_service_outlined,
              title: 'Home Services',
              onTap: () => Navigator.pop(context),
            ),
            _DrawerItem(
              icon: Icons.local_hospital_outlined,
              title: 'Health & Medical',
              onTap: () => Navigator.pop(context),
            ),
            _DrawerItem(
              icon: Icons.attach_money_outlined,
              title: 'Loans & Finance',
              onTap: () => Navigator.pop(context),
            ),

            const Divider(color: Colors.white24, height: 24),

            _DrawerItem(
              icon: Icons.favorite_border,
              title: 'Saved Services',
              onTap: () => Navigator.pop(context),
            ),
            _DrawerItem(
              icon: Icons.history,
              title: 'Recently Viewed',
              onTap: () => Navigator.pop(context),
            ),

            const Spacer(),

            /// Footer
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                '© 2026 Services App',
                style: TextStyle(color: Colors.white54, fontSize: 12),
              ),
            ),
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
        style: const TextStyle(
          color: Colors.white,
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: onTap,
    );
  }
}
