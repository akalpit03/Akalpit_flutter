import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:akalpit/features/editor/editor.dart';
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
 
      // Floating action button to create a post
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const AkalpitEditorPage(),
            ),
          );
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.edit),
      ),
    );
  }
}
