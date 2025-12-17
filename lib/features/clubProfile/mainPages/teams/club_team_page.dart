import 'package:akalpit/features/clubProfile/mainPages/teams/TeamWidgets/admin_header.dart';
import 'package:akalpit/features/clubProfile/mainPages/teams/TeamWidgets/members_card.dart';
import 'package:flutter/material.dart';

class ClubTeamPage extends StatelessWidget {
  final bool isAdmin;

  const ClubTeamPage({
    super.key,
    required this.isAdmin,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const SingleChildScrollView(
        child: Column(
          children: [
            AdminHeader(),
            SizedBox(height: 24),
            MembersList(),
          ],
        ),
      ),
      floatingActionButton: isAdmin
          ? FloatingActionButton(
              onPressed: () {
                
              },
              child: const Icon(Icons.add),
              backgroundColor: Colors.white,
            )
          : null,
    );
  }
}
