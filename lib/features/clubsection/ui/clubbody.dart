import 'package:flutter/material.dart';
import 'package:akalpit/features/clubsection/ui/widget/list/club_following_list.dart';
import 'package:akalpit/features/clubsection/ui/widget/list/clublist.dart';

class ClubBody extends StatelessWidget {
  const ClubBody({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        SizedBox(height: 12),
_SectionTitle(title: "Club Membership"), SizedBox(height: 16),
        /// ================= STATUS SECTION =================
        StatusList(),

       
 SizedBox(height: 16),
        Divider(height: 1),

        SizedBox(height: 16),

        
        /// ================= FOLLOWING CLUBS TITLE =================
        _SectionTitle(title: "Following Clubs"),

        SizedBox(height: 8),

        ChatList(),

        SizedBox(height: 24),
      ],
    );
  }
}

/// ================= SECTION TITLE =================
class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
