import 'package:akalpit/features/clubProfile/services/utils/roleenum.dart';
import 'package:akalpit/features/clubProfile/ui/mainPages/about/club_about_page.dart';
import 'package:akalpit/features/clubProfile/ui/miscellaneous/joinrequests.dart';
import 'package:akalpit/features/clubProfile/ui/widgets/rules.dart';
import 'package:flutter/material.dart';
import '../../miscellaneous/settings_screen.dart';

class ClubAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String clubTitle;
  final String imageUrl;
  final String role;
  final String clubId;
  final PreferredSizeWidget? bottom;

  const ClubAppBar({
    super.key,
    required this.clubTitle,
    required this.imageUrl,
    required this.role,
    required this.clubId,
    this.bottom,
  });

  @override
  Size get preferredSize =>
      Size.fromHeight(kToolbarHeight + (bottom?.preferredSize.height ?? 0));

  /// 🖼️ Image preview (WhatsApp-like)
  void _openImagePreview(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: Colors.black,
      builder: (_) => GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Scaffold(
          backgroundColor: Colors.black,
          body: Center(
            child: InteractiveViewer(
              child: Hero(
                tag: 'club-image-$clubId',
                child: Image.network(imageUrl),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// 📄 Navigate to policies / description page
  void _openClubInfo(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ClubAboutPage(
                  isAdmin: role == "admin" || role == "owner",
                ),
      ),
    );
  }

  /// 📥 Navigate to join requests page
  void _openJoinRequests(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ClubJoinRequestsPage(clubId: clubId),
      ),
    );
  }

  /// ℹ️ Navigate to custom info page (YOU will replace target screen)
  void _openInfoPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) =>  ClubPoliciesPage(clubId: clubId),
    
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      elevation: 0,
      title: Row(
        children: [
          const SizedBox(width: 16),

          /// 🖼️ IMAGE TAP
          GestureDetector(
            onTap: () => _openImagePreview(context),
            child: Hero(
              tag: 'club-image-$clubId',
              child: CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage(imageUrl),
                backgroundColor: Colors.grey.shade300,
              ),
            ),
          ),

          const SizedBox(width: 12),

          /// 📝 TITLE TAP
          Expanded(
            child: InkWell(
              onTap: () => _openClubInfo(context),
              borderRadius: BorderRadius.circular(6),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Text(
                  clubTitle,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),

      /// ⚙️ ACTIONS
      actions: [
        /// ℹ️ INFO BUTTON (Visible to everyone)
        IconButton(
          icon: const Icon(Icons.info_outline),
          tooltip: "Club Info",
          onPressed: () => _openInfoPage(context),
        ),

        /// Admin / Owner menu
        if (role == 'admin' || role == 'owner')
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert),
            onSelected: (value) {
              switch (value) {
                case 'join_requests':
                  _openJoinRequests(context);
                  break;

                case 'settings':
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const ClubSettingsPage(),
                    ),
                  );
                  break;
              }
            },
            itemBuilder: (_) => const [
              PopupMenuItem(
                value: 'join_requests',
                child: Row(
                  children: [
                    Icon(Icons.group_add, size: 20),
                    SizedBox(width: 8),
                    Text("Join Requests"),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'settings',
                child: Row(
                  children: [
                    Icon(Icons.settings, size: 20),
                    SizedBox(width: 8),
                    Text("Settings"),
                  ],
                ),
              ),
            ],
          ),
      ],
      bottom: bottom,
    );
  }
}
