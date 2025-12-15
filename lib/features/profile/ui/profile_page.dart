import 'package:akalpit/features/profile/ui/widget/appbar.dart';
import 'package:akalpit/features/profile/ui/widget/profile/profile_header.dart';
import 'package:akalpit/features/profile/ui/widget/profile/profile_tabs.dart';
import 'package:akalpit/features/profile/ui/widget/sidedrawer.dart';
import 'package:flutter/material.dart';
 

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ProfileAppBar(),
      drawer: const ProfileSideDrawer(),
      body: ListView(
        children: const [
          ProfileHeader(),
          Divider(),
          ProfileTabs(),
        ],
      ),
    );
  }
}
