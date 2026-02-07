import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:akalpit/core/store/app_state.dart';
import 'package:akalpit/features/clubsection/services/actions.dart';
import 'package:akalpit/features/clubsection/ui/widget/list/club_following_list.dart';
import 'package:akalpit/features/clubsection/ui/widget/list/clublist.dart';

class ClubBody extends StatefulWidget {
  const ClubBody({super.key});

  @override
  State<ClubBody> createState() => _ClubBodyState();
}

class _ClubBodyState extends State<ClubBody> {
  @override
  void initState() {
    super.initState();

    /// Dispatch only once when screen loads
    StoreProvider.of<AppState>(context, listen: false)
        .dispatch(GetMyClubsRequestAction());
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        SizedBox(height: 12),

        _SectionTitle(title: "Club Membership"),
        SizedBox(height: 16),

        StatusList(),

        SizedBox(height: 16),
        Divider(height: 1),
        SizedBox(height: 16),

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
