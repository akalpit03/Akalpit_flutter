import 'package:akalpit/features/editor/editor.dart';
import 'package:flutter/material.dart';
import 'package:akalpit/features/Feed/ui/sidedrawer/sideDrawer.dart';
import 'package:akalpit/features/Feed/ui/widgets/appbar.dart';
import 'package:akalpit/features/Feed/ui/widgets/feed_body.dart';

class FeedPage extends StatelessWidget {
  const FeedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const FeedAppBar(),
      drawer: const AppSideDrawer(),
      body: const FeedBody(),

      // Floating action button to create a post
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (_) => const AkalpitEditorPage()));
        },
        backgroundColor: Colors.blue, // You can change color
        child: const Icon(Icons.edit), // Pencil icon for creating post
      ),
    );
  }
}
