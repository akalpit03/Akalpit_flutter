import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:penverse/features/home/sample.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_defaults.dart';

 
import './component/app_navigation_bar.dart';

 

/// This page will contain all the bottom navigation tabs
class EntryPointUI extends StatefulWidget {
  const EntryPointUI({super.key});

  @override
  State<EntryPointUI> createState() => _EntryPointUIState();
}

class _EntryPointUIState extends State<EntryPointUI> {
  /// Current Page
  int currentIndex = 0;

  /// On labelLarge navigation tap
  void onBottomNavigationTap(int index) {
    if (index == 2) {
      // 👇 Replace first nav with second nav
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => SimplePage()),
      );
    } else {
      setState(() => currentIndex = index);
    }
    if (index == 3) {
      // 👇 Replace first nav with second nav
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) =>  SimplePage()),
      );
    } else {
      setState(() => currentIndex = index);
    }
    if (index == 4) {
      // 👇 Replace first nav with second nav
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) =>  SimplePage()),
      );
    } else {
      setState(() => currentIndex = index);
    }
    currentIndex = index;
    setState(() {});
  }

  List<Widget> pages = [
  const SimplePage(),
  const SimplePage(),
  const SimplePage(),
  const SimplePage(),
  const SimplePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageTransitionSwitcher(
        transitionBuilder: (child, primaryAnimation, secondaryAnimation) {
          return SharedAxisTransition(
            animation: primaryAnimation,
            secondaryAnimation: secondaryAnimation,
            transitionType: SharedAxisTransitionType.horizontal,
            fillColor: AppColors.scaffoldBackground,
            child: child,
          );
        },
        duration: AppDefaults.duration,
        child: pages[currentIndex],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AppBottomNavigationBar(
        currentIndex: currentIndex,
        onNavTap: onBottomNavigationTap,
      ),
    );
  }
}
