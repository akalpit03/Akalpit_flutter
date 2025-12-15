import 'package:flutter/material.dart';
import 'package:penverse/features/Feed/ui/sidedrawer/sideDrawer.dart';
import 'package:penverse/features/Feed/ui/widgets/appbar.dart';
import 'package:penverse/features/Feed/ui/widgets/feed_body.dart';
 

class FeedPage extends StatelessWidget {
  const FeedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar:   FeedAppBar(),
      drawer:   AppSideDrawer(), // 👈 SIDE DRAWER HERE
      body:   FeedBody(),
    );
  }
}
