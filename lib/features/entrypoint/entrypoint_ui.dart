import 'package:akalpit/features/profile/ui/profile_page.dart';
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:akalpit/features/Events/ui/events.dart';
import 'package:akalpit/features/Feed/sample.dart';
import 'package:akalpit/features/Feed/sample2.dart';
import 'package:akalpit/features/Feed/ui/feed.dart';

import 'package:akalpit/features/clubs/ui/clubpage.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_defaults.dart';
import 'component/app_navigation_bar.dart';

class EntryPointUI extends StatefulWidget {
  const EntryPointUI({super.key});

  @override
  State<EntryPointUI> createState() => _EntryPointUIState();
}

class _EntryPointUIState extends State<EntryPointUI> {
  int currentIndex = 0;

  final List<Widget> pages = const [
    FeedPage(), // Home
    ClubPage(),
    EventPage(), // Events
    SimplePage2(), // Services
    ProfilePage(), // Profile
  ];

  void onBottomNavigationTap(int index) {
    if (index == currentIndex) return;

    setState(() => currentIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageTransitionSwitcher(
        duration: AppDefaults.duration,
        transitionBuilder: (child, animation, secondaryAnimation) {
          return SharedAxisTransition(
            animation: animation,
            secondaryAnimation: secondaryAnimation,
            transitionType: SharedAxisTransitionType.horizontal,
            fillColor: AppColors.cardBackground,
            child: child,
          );
        },
        child: pages[currentIndex],
      ),
      bottomNavigationBar: AppBottomNavigationBar(
        currentIndex: currentIndex,
        onNavTap: onBottomNavigationTap,
      ),
    );
  }
}
