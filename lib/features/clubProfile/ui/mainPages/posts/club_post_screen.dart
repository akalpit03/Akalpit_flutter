import 'package:akalpit/features/clubProfile/ui/mainPages/posts/post_body.dart';
import 'package:flutter/material.dart';

class ClubPostsPage extends StatelessWidget {
  const ClubPostsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const SampleFeedPage(),

      /// ================= ADD POST BUTTON =================
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        elevation: 4,
        onPressed: () {
          // TODO: Open create post / poll / announcement
        },
        child: const Icon(
          Icons.add,
          color: Colors.black,
        ),
      ),
    );
  }
}
