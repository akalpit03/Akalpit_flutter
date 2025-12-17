import 'package:akalpit/features/clubsection/ui/widget/cards/following_club_card.dart';
import 'package:flutter/material.dart';

class ChatList extends StatelessWidget {
  const ChatList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 12,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return ClubUpdateCard(
          clubName: 'Club Name ${index + 1}',
          subtitle: 'Title of the recent post by admin.',
          newEventsCount: index % 3 == 0 ? 5 + index : 0,
        );
      },
    );
  }
}
