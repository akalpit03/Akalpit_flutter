import 'package:akalpit/features/clubProfile/mainPages/about/club_about_page.dart';
import 'package:akalpit/features/clubProfile/mainPages/events/club_events_page.dart';
import 'package:akalpit/features/clubProfile/mainPages/posts/admin_app_bar.dart';
import 'package:akalpit/features/clubProfile/mainPages/posts/club_post_screen.dart';
import 'package:akalpit/features/clubProfile/mainPages/posts/services/role.dart';
import 'package:akalpit/features/clubProfile/mainPages/teams/club_team_page.dart';
import 'package:flutter/material.dart';

// your previous app bar file

class ClubHomePage extends StatelessWidget {
  const ClubHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: ClubAppBar(
          clubTitle: "Flutter Dev Club",
          imageUrl: "https://via.placeholder.com/150",
          role: ClubRole.admin,
          bottom: TabBar(
            isScrollable: true,
            tabs: [
              Tab(text: "Posts"),
              Tab(text: "Events"),
              Tab(text: "Team"),
              Tab(text: "About"),
            ],
          ),
        ),
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(), // optional
          children: [
            ClubPostsPage(),
            ClubEventsPage(),
            ClubTeamPage(),
            ClubAboutPage(),
          ],
        ),
      ),
    );
  }
}
