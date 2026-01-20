import 'package:akalpit/features/posts/story/ui/story_screen.dart';
import 'package:flutter/material.dart';
import 'package:akalpit/features/Feed/ui/widgets/feedcard.dart';

import 'package:akalpit/features/Feed/ui/widgets/storylist.dart';

class FeedBody extends StatelessWidget {
  const FeedBody({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding:   EdgeInsets.only(top: 8, bottom: 16),
      children:   [
        ActiveUsersList(),
        SizedBox(height: 12),
        FeedCard(
          onOpenPost: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const StoryScreen(topicId: "696f21ba6ea90a243baad1c8" )),
            );
          },
          onLike: () {
            // like logic
          },
          // onComment: () {
          //   Navigator.push(
          //     context,
          //     MaterialPageRoute(builder: (_) => const CommentPage()),
          //   );
          // },
          onView: () {
            // analytics / viewers page
          },
        ),
        FeedCard(),
        FeedCard(),
      ],
    );
  }
}
