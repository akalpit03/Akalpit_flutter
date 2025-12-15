import 'package:flutter/material.dart';
import 'package:akalpit/features/clubs/ui/widget/cards/following_club_card.dart';

class ChatList extends StatelessWidget {
  const ChatList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 12,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return ChatCard(
          name: 'Clubname ${index + 1}',
          unreadCount: index % 3 == 0 ? 2 + index : 0,
        );
      },
    );
  }
}
