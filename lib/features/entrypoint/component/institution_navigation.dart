import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../entrypoint/component/bottom_app_bar_item.dart'; // reuse BottomNavItem & CustomBottomAppBar

class InstitutionBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onNavTap;

  const InstitutionBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onNavTap,
  });

  @override
  Widget build(BuildContext context) {
    return CustomBottomAppBar(
      currentIndex: currentIndex,
      onTap: onNavTap,
      items: const [
        BottomNavItem(
          icon: Icons.miscellaneous_services_outlined,
          activeIcon: Icons.miscellaneous_services,
          label: 'Services',
        ),
        BottomNavItem(
          icon: Icons.book_online_outlined,
          activeIcon: Icons.book_online,
          label: 'Bookings',
        ),
        BottomNavItem(
          icon: Icons.post_add_outlined,
          activeIcon: Icons.post_add,
          label: 'Posts',
        ),
        BottomNavItem(
          icon: Icons.groups_outlined,
          activeIcon: Icons.groups,
          label: 'Councils',
        ),
        BottomNavItem(
          icon: Icons.person_outline,
          activeIcon: Icons.person,
          label: 'Profile',
        ),
      ],
    );
  }
}