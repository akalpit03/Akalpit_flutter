import 'package:flutter/material.dart';
import 'package:akalpit/features/entrypoint/component/bottom_app_bar_item.dart';
import '../../../core/constants/app_colors.dart';

class AppBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onNavTap;

  const AppBottomNavigationBar({
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
          icon: Icons.newspaper_outlined,
          activeIcon: Icons.newspaper,
          label: 'Feed',
        ),
        BottomNavItem(
          icon: Icons.groups_outlined,
          activeIcon: Icons.groups,
          label: 'Clubs',
        ),
        BottomNavItem(
          icon: Icons.event_outlined,
          activeIcon: Icons.event,
          label: 'Events',
        ),
        BottomNavItem(
          icon: Icons.handshake_outlined,
          activeIcon: Icons.handshake,
          label: 'Services',
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
