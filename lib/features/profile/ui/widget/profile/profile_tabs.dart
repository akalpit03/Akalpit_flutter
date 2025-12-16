import 'package:akalpit/features/profile/ui/widget/profile/profile_about_tab.dart';
import 'package:akalpit/features/profile/ui/widget/profile/profile_books_tab.dart';
import 'package:akalpit/features/profile/ui/widget/profile/profile_post_tab.dart';
import 'package:flutter/material.dart';
 

class ProfileTabs extends StatelessWidget {
  const ProfileTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
      length: 3,
      child: Column(
        children: const [
          TabBar(
            labelColor: Colors.blueGrey,
            indicatorColor: Colors.grey,
            tabs: [
              Tab(text: 'My Posts'),
              Tab(text: 'Events'),
              Tab(text: 'About'),
            ],
          ),
          SizedBox(
            height: 800,
            child: TabBarView(
              children: [
                ProfilePostsTab(),
                ProfileBooksTab(),
                ProfileAboutTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
