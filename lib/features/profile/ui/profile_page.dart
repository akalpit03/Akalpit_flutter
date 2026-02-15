import 'dart:convert';

import 'package:akalpit/core/store/app_state.dart';
import 'package:akalpit/features/profile/services/models/userProfileModel.dart';
import 'package:akalpit/features/profile/services/profileActions.dart';
import 'package:akalpit/features/profile/ui/createProfile.dart';
import 'package:akalpit/features/profile/services/viewmodels/profileviewmodel.dart';
import 'package:akalpit/features/profile/ui/widget/appbar.dart';
import 'package:akalpit/features/profile/ui/widget/profile/profile_header.dart';
import 'package:akalpit/features/profile/ui/widget/profile/profile_tabs.dart';
import 'package:akalpit/features/profile/ui/widget/sidedrawer.dart';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  /// If userId is null → MY PROFILE
  /// If userId is provided → PUBLIC PROFILE
  final String? userId;

  const ProfilePage({super.key, this.userId});

  bool get isPublic => userId != null;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

/// ===============================
/// 🔵 Combined ViewModel
/// ===============================
class _ProfilePageVM {
  final ProfileViewModel profileVM;
  final String? myUserId;

  _ProfilePageVM({
    required this.profileVM,
    required this.myUserId,
  });

  static _ProfilePageVM fromStore(Store<AppState> store) {
    return _ProfilePageVM(
      profileVM: ProfileViewModel.fromStore(store),
      myUserId: store.state.authState.userId, // 🔥 AUTH USER ID
    );
  }
}

class _ProfilePageState extends State<ProfilePage> {
  UserProfileModel? _localUser;

  @override
  void initState() {
    super.initState();

    if (!widget.isPublic) {
      _loadLocalProfile();
    }
  }

  Future<void> _loadLocalProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final userString = prefs.getString('user');

    if (userString != null) {
      final decoded = jsonDecode(userString);
      setState(() {
        _localUser = UserProfileModel.fromJson(decoded);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ProfilePageVM>(
      distinct: true,
      converter: _ProfilePageVM.fromStore,
      onInit: (store) {
        if (widget.isPublic) {
          store.dispatch(GetPublicProfileAction(widget.userId!));
        } else {
          store.dispatch(GetMyProfileAction());
        }
      },
      builder: (context, combinedVM) {
        final vm = combinedVM.profileVM;
        final myUserId = combinedVM.myUserId;

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

          final viewedUserId = vm.profile!.id;

          // 🔥 SELF CHECK USING AUTH STATE
          final bool isSelf =
              myUserId != null && viewedUserId == myUserId;

          return Scaffold(
            appBar: const ProfileAppBar(isPublic: true),
            body: ListView(
              children: [
                ProfileHeader(
                  profile: vm.profile!,
                  isSelf: isSelf, // 🔥 pass to header
                ),
                const Divider(),
                ProfileTabs(profile: vm.profile!),
              ],
            ),
          );
        }

        /// ================================
        /// 🟢 MY PROFILE MODE
        /// ================================

        // 1️⃣ Show local cached profile instantly
        if (_localUser != null) {
          return Scaffold(
            appBar: const ProfileAppBar(),
            drawer: const ProfileSideDrawer(),
            body: ListView(
              children: [
                ProfileHeader(
                  profile: _localUser!,
                  isSelf: true, // 🔥 always self
                ),
                const Divider(),
                ProfileTabs(profile: _localUser!),
              ],
            ),
          );
        }

        // 2️⃣ Loading
        if (vm.isLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // 3️⃣ No profile → Create profile
        if (vm.error != null || vm.profile == null) {
          return const ProfileFormScreen();
        }

        // 4️⃣ Profile exists
        return Scaffold(
          appBar: const ProfileAppBar(),
          drawer: const ProfileSideDrawer(),
          body: ListView(
            children: [
              ProfileHeader(
                profile: vm.profile!,
                isSelf: true, // 🔥 self
              ),
              const Divider(),
              ProfileTabs(profile: vm.profile!),
            ],
          ),
        );
      },
    );
  }
}
