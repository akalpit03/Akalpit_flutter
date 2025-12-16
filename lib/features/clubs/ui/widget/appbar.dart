import 'package:flutter/material.dart';

class ClubsAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ClubsAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0.5,

      /// Drawer icon
      leading: Builder(
        builder: (context) {
          return IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          );
        },
      ),

      /// Title
      title: const Text(
        'Clubs & Communities',
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),

      centerTitle: false,

      /// Actions
      actions: [
        /// Search bar
        Container(
          width: 180,
          height: 36,
          margin: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(18),
          ),
          child: const TextField(
            decoration: InputDecoration(
              hintText: 'Search',
              hintStyle: TextStyle(fontSize: 13),
              prefixIcon: Icon(Icons.search, size: 18),
              border: InputBorder.none,
              contentPadding: EdgeInsets.zero,
            ),
          ),
        ),

        const SizedBox(width: 8),

        /// More options
        PopupMenuButton<String>(
          icon: const Icon(Icons.more_vert),
          onSelected: (value) {
            // handle actions
          },
          itemBuilder: (context) => const [
            PopupMenuItem(
              value: 'create',
              child: Text('Join a Club'),
            ),
            PopupMenuItem(
              value: 'manage',
              child: Text('Manage Communities'),
            ),
            PopupMenuItem(
              value: 'settings',
              child: Text('Settings'),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
