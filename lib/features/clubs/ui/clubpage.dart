import 'package:flutter/material.dart';
import 'package:penverse/features/clubs/ui/clubbody.dart';
import 'package:penverse/features/clubs/ui/sidedrawer/sidedrawer.dart';
import 'package:penverse/features/clubs/ui/widget/appbar.dart';

class ClubPage extends StatelessWidget {
  const ClubPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppSideDrawer(),
      appBar: const ClubsAppBar(),
      body: const ClubBody(),
    );
  }
}
