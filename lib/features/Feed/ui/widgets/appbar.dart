import 'dart:convert';
import 'package:akalpit/features/notifications/notification.dart';
import 'package:akalpit/features/search/screens/profilesearch/searchScreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FeedAppBar extends StatefulWidget implements PreferredSizeWidget {
  const FeedAppBar({super.key});

  @override
  State<FeedAppBar> createState() => _FeedAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _FeedAppBarState extends State<FeedAppBar> {
  int _notificationCount = 0;

  @override
  void initState() {
    super.initState();
    _loadNotificationCount();
  }

  /// 🔔 Reads the saved list and updates the badge count
  Future<void> _loadNotificationCount() async {
    final prefs = await SharedPreferences.getInstance();
    final String? data = prefs.getString('notifications_history');
    if (data != null) {
      final List<dynamic> history = jsonDecode(data);
      if (mounted) {
        setState(() {
          _notificationCount = history.length;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Builder(
        builder: (context) {
          return IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          );
        },
      ),
      title: const Text(
        'AKALPIT',
        style: TextStyle(
          fontWeight: FontWeight.w600,
          letterSpacing: 1.1,
        ),
      ),
      centerTitle: true,
      actions: [
        /// Search
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const ProfileSearchScreen()),
            );
          },
        ),

        /// Notifications with Badge 🔴
        Badge(
          label: Text('$_notificationCount'),
          isLabelVisible: _notificationCount > 0,
          backgroundColor: Colors.red,
          padding: const EdgeInsets.symmetric(horizontal: 4),
          alignment: const Alignment(0.7, -0.6),
          child: IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () async {
              // Navigate to notification page
              await Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const NotificationPage()),
              );
              // Refresh count when coming back from notification page
              _loadNotificationCount();
            },
          ),
        ),

        /// Settings
        // IconButton(
        //   icon: const Icon(Icons.settings_outlined),
        //   onPressed: () {},
        // ),

        const SizedBox(width: 8),
      ],
    );
  }
}