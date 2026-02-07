import 'package:akalpit/core/store/app_state.dart';
import 'package:akalpit/features/clubProfile/services/clubactions/actions.dart';
import 'package:akalpit/features/clubProfile/services/states/clubstate.dart';
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
  final String role;

  const ClubHomePage({
    super.key,
    required this.clubId,
    required this.role,
  });

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, Club?>(
      distinct: true,

      /// 🔥 FETCH CLUB WHEN PAGE LOADS
      onInit: (store) {
        store.dispatch(GetClubAction(clubId));
      },

      converter: (store) {
        return store.state.clubState.club;
      },

      builder: (context, club) {
        if (club == null) {
   
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final  role =  this.role; // TODO: derive dynamically
        print("User Role in Club: $role");
        return DefaultTabController(
          length: 4,
          child: Scaffold(
            appBar: ClubAppBar(
              clubTitle: club.clubName,
              imageUrl: club.image ?? "",
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
                /// 🔥 Now this page can safely read club from Redux
                  ClubPostsPage(
                  clubId: club.id,
                  isAdmin: role == "admin" || role == "owner",
                ),

                ClubEventsPage(
                       clubId: club.id,
                  isAdmin: role == "admin" || role == "owner",
                ),

                ClubTeamPage(
                  clubId: club.id,
                  isAdmin:  role == "admin" || role == "owner",
                  owner: club.owner,
                ),

                ClubAboutPage(
                  isAdmin: role == "admin" || role == "owner",
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
