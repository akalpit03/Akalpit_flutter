import 'package:flutter/material.dart';
import 'package:akalpit/features/Feed/ui/widgets/feedcard.dart';

import 'package:akalpit/features/Feed/ui/widgets/storylist.dart';

class FeedBody extends StatelessWidget {
  const FeedBody({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(top: 8, bottom: 16),
      children: const [
        StoryList(),
        SizedBox(height: 12),
        FeedCard(),
        FeedCard(),
        FeedCard(),
      ],
    );
  }
}
