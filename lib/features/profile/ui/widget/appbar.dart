import 'package:akalpit/core/store/app_state.dart';
import 'package:akalpit/features/auth/ui/screens/login_screen.dart';
import 'package:akalpit/features/profile/ui/createProfile.dart';
import 'package:akalpit/features/profile/ui/viewmodel/profileviewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// 👇 true when viewing someone else’s profile
  final bool isPublic;

  const ProfileAppBar({
    super.key,
    this.isPublic = false,
  });

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ProfileViewModel>(
      distinct: true,
      converter: ProfileViewModel.fromStore,
      builder: (context, vm) {
        return AppBar(
          /// 🔹 PUBLIC → Back button
          /// 🔹 SELF → Drawer menu
          leading: isPublic
              ? IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => Navigator.pop(context),
                )
              : Builder(
                  builder: (context) => IconButton(
                    icon: const Icon(Icons.menu),
                    onPressed: () => Scaffold.of(context).openDrawer(),
                  ),
                ),

          title: Text(
            isPublic ? 'Profile' : 'Profile Section',
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),

          /// 🔹 PUBLIC → no actions
          /// 🔹 SELF → edit + logout
          actions: isPublic
              ? []
              : [
                  PopupMenuButton<String>(
                    onSelected: (value) {
                      switch (value) {
                        case 'edit':
                          if (vm.profile == null) return;

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ProfileFormScreen(
                                profile: vm.profile,
                              ),
                            ),
                          );
                          break;

                        case 'logout':
                          _showLogoutDialog(context);
                          break;
                      }
                    },
                    itemBuilder: (context) => const [
                      PopupMenuItem(
                        value: 'edit',
                        child: Row(
                          children: [
                            Icon(Icons.edit, size: 18),
                            SizedBox(width: 8),
                            Text('Edit Profile'),
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        value: 'logout',
                        child: Row(
                          children: [
                            Icon(Icons.logout, size: 18),
                            SizedBox(width: 8),
                            Text('Logout'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
        );
      },
    );
  }

  

void _showLogoutDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Logout'),
      content: const Text('Are you sure you want to logout?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () async {
            // 1. Clear local storage
            final prefs = await SharedPreferences.getInstance();
            await prefs.clear(); 

            // 2. Navigate and prevent going back
            if (context.mounted) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginScreen(), // Replace with your Login Widget name
                ),
                (route) => false, // This condition removes all previous routes
              );
            }
          },
          child: const Text(
            'Logout',
            style: TextStyle(color: Colors.red),
          ),
        ),
      ],
    ),
  );
}
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
