import 'package:akalpit/core/store/app_state.dart';
import 'package:akalpit/features/clubProfile/services/states/clubs.dart';
import 'package:akalpit/features/clubProfile/services/utils/roleenum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:akalpit/features/clubProfile/ui/mainPages/about/club_about_page.dart';
import 'package:akalpit/features/clubProfile/ui/mainPages/events/ui/club_events_page.dart';
import 'package:akalpit/features/clubProfile/ui/mainPages/adminAppBar/club_app_bar.dart';
import 'package:akalpit/features/clubProfile/ui/mainPages/posts/club_post_screen.dart';
import 'package:akalpit/features/clubProfile/ui/mainPages/teams/club_team_page.dart';

class ClubHomePage extends StatelessWidget {
  final String clubId;

  const ClubHomePage({
    super.key,
    required this.clubId,
  });

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, Club?>(
      distinct: true,
      converter: (store) {
        return store.state.clubScreenState.byId[clubId];
      },
      builder: (context, club) {
       
        if (club == null) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        
        final ClubRole role = ClubRole.admin;  

        return DefaultTabController(
          length: 4,
          child: Scaffold(
            appBar: ClubAppBar(
              clubTitle: club.clubName,
              imageUrl: club.image!,
              role: role,
              clubId: club.id,
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(52),
                child: Container(
                  color: Colors.transparent,
                  child: const TabBar(
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicatorColor: Colors.grey,
                    labelColor: Colors.grey,
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
            body: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              children: [
                ClubPostsPage(
                  // clubId: club.clubId
                  ),
                ClubEventsPage(
                  // clubId: club.clubId,
                  isAdmin: role == ClubRole.admin,
                ),
                ClubTeamPage(
                  clubId: club.id,
                  isAdmin: role == ClubRole.admin,
                  owner: club.owner,
                ),
                ClubAboutPage(
                  // clubId: club.clubId,
                  isAdmin: role == ClubRole.admin,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
