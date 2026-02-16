 
import 'package:akalpit/features/profile/services/models/userProfileModel.dart';
import 'package:akalpit/features/profile/ui/widget/profile/profile_about_tab.dart';
 import 'package:akalpit/features/profile/ui/widget/profile/profile_post_tab.dart';
import 'package:flutter/material.dart';

class ProfileTabs extends StatelessWidget {
  final UserProfileModel profile;

  const ProfileTabs({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          const TabBar(
            labelColor: Colors.blueGrey,
            indicatorColor: Colors.grey,
            tabs: [
              Tab(text: 'About'),
              Tab(text: 'Posts'),
              Tab(text: 'Events'),
            ],
          ),

          /// 👇 Use flexible instead of fixed height
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.7,
            child: const TabBarView(
              children: [
                ProfileAboutTab( ),
                ProfileAboutTab( ),
                ProfileAboutTab( ),
                // ProfilePostsTab(),
               
                // ProfileEventsTab( ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
