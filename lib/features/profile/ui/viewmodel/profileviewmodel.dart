// features/profile/viewmodels/profile_viewmodel.dart

import 'package:akalpit/core/store/app_state.dart';
import 'package:akalpit/features/profile/services/models/userProfileModel.dart';
import 'package:akalpit/features/profile/services/profileActions.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

class ProfileViewModel {
  final bool isLoading;
  final String? error;
  final UserProfileModel? profile;

  /// Actions
  final VoidCallback getProfile;
  final Function(Map<String, dynamic>) createProfile;
  final Function(Map<String, dynamic>) updateProfile;

  ProfileViewModel({
    required this.isLoading,
    this.error,
    this.profile,
    required this.getProfile,
    required this.createProfile,
    required this.updateProfile,
  });

  static ProfileViewModel fromStore(Store<AppState> store) {
    return ProfileViewModel(
      isLoading: store.state.profileState.isLoading,
      error: store.state.profileState.error,
      profile: store.state.profileState.profile,

      /// Fetch logged-in user's profile
      getProfile: () {
        store.dispatch(GetMyProfileAction());
      },

      /// Create new profile
      createProfile: (Map<String, dynamic> data) {
        store.dispatch(CreateProfileAction(data));
      },

      /// Update existing profile
      updateProfile: (Map<String, dynamic> data) {
        store.dispatch(UpdateProfileAction(data));
      },
    );
  }
}
