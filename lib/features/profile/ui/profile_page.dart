import 'package:akalpit/core/store/app_state.dart';
import 'package:akalpit/features/profile/ui/createProfile.dart';
import 'package:akalpit/features/profile/ui/viewmodel/profileviewmodel.dart';
import 'package:akalpit/features/profile/ui/widget/appbar.dart';
import 'package:akalpit/features/profile/ui/widget/profile/profile_header.dart';
import 'package:akalpit/features/profile/ui/widget/profile/profile_tabs.dart';
import 'package:akalpit/features/profile/ui/widget/sidedrawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
 

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ProfileViewModel>(
      converter: ProfileViewModel.fromStore,
      builder: (context, vm) {
        // 1. Show a loading spinner while we check the backend
        if (vm.isLoading) {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }

        // 2. If no profile is found, redirect to the "Setup" screen
        if (vm.profile == null) {
          return CreateProfileScreen(vm: vm);
        }

        // 3. If profile exists, show your current layout
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