import 'package:akalpit/core/store/app_state.dart';
import 'package:akalpit/features/clubProfile/ui/mainPages/clubHomePage.dart';
import 'package:akalpit/features/clubsection/ui/viewmodel/clubStateViewmodel.dart';
import 'package:akalpit/features/clubsection/ui/widget/cards/following_club_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class ChatList extends StatelessWidget {
  const ChatList({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ClubScreenViewModel>(
      converter: ClubScreenViewModel.fromStore,
      distinct: true,
      builder: (context, vm) {
        final followingClubs = vm.followingClubs.values.toList();

        if (followingClubs.isEmpty) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Center(
              child: Text("You're not following any clubs yet."),
            ),
          );
        }

        return ListView.builder(
          itemCount: followingClubs.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final club = followingClubs[index];

            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ClubHomePage(clubId: club.id, role: "member"),
                  ),
                );
              },
              child: ClubUpdateCard(
                clubName: club.clubName,
                subtitle: "Tap to view updates",
                newEventsCount: 0,
                imageUrl: club.clubImage,
              ),
            );
          },
        );
      },
    );
  }
}
