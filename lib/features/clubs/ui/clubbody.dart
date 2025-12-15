import 'package:flutter/material.dart';
import 'package:penverse/features/clubs/ui/widget/list/club_following_list.dart';
import 'package:penverse/features/clubs/ui/widget/list/clublist.dart';
 

class ClubBody extends StatelessWidget {
  const ClubBody({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        SizedBox(height: 12),

        /// Status Section
        StatusList(),

        SizedBox(height: 16),

        Divider(height: 1),

        /// Chat List
        ChatList(),
      ],
    );
  }
}
