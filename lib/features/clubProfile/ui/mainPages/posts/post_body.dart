import 'package:akalpit/features/clubProfile/ui/mainPages/posts/widgets/announcementcard.dart';
import 'package:akalpit/features/clubProfile/ui/mainPages/posts/widgets/infopostcard.dart';
import 'package:akalpit/features/clubProfile/ui/mainPages/posts/widgets/pollcard.dart';
import 'package:akalpit/features/clubProfile/ui/mainPages/posts/widgets/postcard.dart';
import 'package:flutter/material.dart';

class SampleFeedPage extends StatelessWidget {
  const SampleFeedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          PostCard(),
          PollCard(),
          AnnouncementCard(),
          InfoPostCard(),
        ],
      ),
    );
  }
}
