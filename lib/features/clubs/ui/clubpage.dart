import 'package:flutter/material.dart';
import 'package:akalpit/features/clubs/ui/clubbody.dart';
import 'package:akalpit/features/clubs/ui/sidedrawer/sidedrawer.dart';
import 'package:akalpit/features/clubs/ui/widget/appbar.dart';

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
