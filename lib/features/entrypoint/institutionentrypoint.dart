import 'package:akalpit/features/entrypoint/component/institution_navigation.dart';
import 'package:akalpit/features/entrypoint/instittutions.dart';
import 'package:akalpit/features/institutions/UI/adminside/bookings/adminBookingsPage.dart';
import 'package:akalpit/features/institutions/UI/adminside/councils/councils_List.dart';
import 'package:akalpit/features/institutions/UI/adminside/postUpdates/admin_post_page.dart';
import 'package:akalpit/features/institutions/UI/adminside/profile/profilePage.dart';
import 'package:akalpit/features/institutions/UI/adminside/services/servicesPage.dart';
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_defaults.dart';
 
 

class InstitutionEntryPointUI extends StatefulWidget {
  final int initialIndex;
  const InstitutionEntryPointUI({super.key, this.initialIndex = 0});

  @override
  State<InstitutionEntryPointUI> createState() =>
      _InstitutionEntryPointUIState();
}

class _InstitutionEntryPointUIState extends State<InstitutionEntryPointUI> {
  late int currentIndex;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex;
  }

  final List<Widget> _pages = const [
    InstitutionHomePage(),
    AdminBookingsPage(),
    AdminPostsPage(),
    CouncilsPage(),
    InstitutionProfilePage(),
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
        child: _pages[currentIndex],
      ),
      bottomNavigationBar: InstitutionBottomNavigationBar(
        currentIndex: currentIndex,
        onNavTap: onBottomNavigationTap,
      ),
    );
  }
}