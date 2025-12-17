import 'package:flutter/material.dart';

import 'package:akalpit/features/clubProfile/mainPages/about/club_about_page.dart';
import 'package:akalpit/features/clubProfile/mainPages/events/club_events_page.dart';
import 'package:akalpit/features/clubProfile/mainPages/posts/posts_app_bar.dart';
import 'package:akalpit/features/clubProfile/mainPages/posts/club_post_screen.dart';
import 'package:akalpit/features/clubProfile/mainPages/posts/services/role.dart';
import 'package:akalpit/features/clubProfile/mainPages/teams/club_team_page.dart';

class ClubHomePage extends StatelessWidget {
  const ClubHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: ClubAppBar(
          clubTitle: "The Akalpit Club",
          imageUrl: 'https://res.cloudinary.com/dmxskf3hq/image/upload/v1757363826/uploads/ysrx2zcokdft4ishsxwb.png',
          role: ClubRole.admin,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(52),
            child: Container(
              color: Colors.transparent,
              child: const TabBar(
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorColor: Colors.grey,
                labelColor: Colors.grey, // active tab text
                unselectedLabelColor: Colors.white,
                labelStyle: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
                tabs: [
                  Tab(text: "Posts"),
                  Tab(text: "Events"),
                  Tab(text: "Team"),
                  Tab(text: "About"),
                ],
              ),
            ),
          ),
        ),
        body: const TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            ClubPostsPage(),
            ClubEventsPage(),
            ClubTeamPage(isAdmin: true),
            ClubAboutPage(),
          ],
        ),
      ),
    );
  }
}
