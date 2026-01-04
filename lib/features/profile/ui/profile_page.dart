import 'dart:convert';

import 'package:akalpit/core/store/app_state.dart';
import 'package:akalpit/features/profile/services/profileActions.dart';
import 'package:akalpit/features/profile/ui/createProfile.dart';
import 'package:akalpit/features/profile/ui/viewmodel/profileviewmodel.dart';
import 'package:akalpit/features/profile/ui/widget/appbar.dart';
import 'package:akalpit/features/profile/ui/widget/profile/profile_header.dart';
import 'package:akalpit/features/profile/ui/widget/profile/profile_tabs.dart';
import 'package:akalpit/features/profile/ui/widget/sidedrawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  /// 👇 If userId is null → MY PROFILE
  /// 👇 If userId is provided → PUBLIC PROFILE
  final String? userId;

  const ProfilePage({super.key, this.userId});

  bool get isPublic => userId != null;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Map<String, dynamic>? _localUser;

  @override
  void initState() {
    super.initState();

    /// Load local user ONLY for self profile
    if (!widget.isPublic) {
      _loadLocalProfile();
    }
  }

  Future<void> _loadLocalProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final userString = prefs.getString('user');

    if (userString != null) {
      setState(() {
        _localUser = jsonDecode(userString);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ProfileViewModel>(
      distinct: true,
      converter: ProfileViewModel.fromStore,

      /// 🔥 SINGLE ENTRY POINT
      onInit: (store) {
        if (widget.isPublic) {
          /// PUBLIC PROFILE
          store.dispatch(GetPublicProfileAction(widget.userId!));
        } else {
          /// MY PROFILE
          if (_localUser == null) {
            store.dispatch(GetMyProfileAction());
          }
        }
      },

      builder: (context, vm) {
        /// ================================
        /// 🔵 PUBLIC PROFILE MODE
        /// ================================
        if (widget.isPublic) {
          if (vm.isLoading) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          if (vm.error != null) {
            return Scaffold(
              body: Center(child: Text(vm.error!)),
            );
          }

          if (vm.profile == null) {
            return const Scaffold(
              body: Center(child: Text("Profile not found")),
            );
          }

          return Scaffold(
            appBar: const ProfileAppBar(isPublic: true),
            body: ListView(
              children: const [
                ProfileHeader(),
                Divider(),
                ProfileTabs(),
              ],
            ),
          );
        }

        /// ================================
        /// 🟢 MY PROFILE MODE
        /// ================================

        /// 1️⃣ Local cached profile (fast)
        if (_localUser != null) {
          return Scaffold(
            appBar: const ProfileAppBar(),
            drawer: const ProfileSideDrawer(),
            body: ListView(
              children: [
                ProfileHeader(localProfile: _localUser),
                const Divider(),
                const ProfileTabs(),
              ],
            ),
          );
        }

        /// 2️⃣ Loading
        if (vm.isLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        /// 3️⃣ No profile → Create Profile
        if (vm.error != null || vm.profile == null) {
          return const ProfileFormScreen();
        }

        /// 4️⃣ Profile exists
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
      },
    );
  }
}
