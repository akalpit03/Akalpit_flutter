import 'package:akalpit/features/Feed/ui/widgets/feedcard.dart';
import 'package:flutter/material.dart';
 

class ProfilePostsTab extends StatelessWidget {
  const ProfilePostsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        FeedCard(),
        FeedCard(),
        FeedCard(),
      ],
    );
  }
}
