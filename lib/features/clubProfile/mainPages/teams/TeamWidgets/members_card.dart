import 'package:akalpit/features/clubProfile/mainPages/teams/TeamWidgets/memberCard.dart';
import 'package:flutter/material.dart';

class MembersList extends StatelessWidget {
  const MembersList();

  @override
  Widget build(BuildContext context) {
    final members = [
      {'name': 'Vivek Raj', 'role': 'Secretary'},
      {'name': 'Ashish', 'role': ' Joint Secretary'},
      {'name': 'ritik', 'role': 'Joint Secretary'},
      {'name': 'Dummy', 'role': 'Volunteer'},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Members',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          ...members.map(
            (member) => MemberCard(
              name: member['name']!,
              designation: member['role']!,
            ),
          ),
        ],
      ),
    );
  }
}
