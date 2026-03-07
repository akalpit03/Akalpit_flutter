import 'package:image_picker/image_picker.dart';
import 'package:akalpit/core/store/app_state.dart';
import 'package:akalpit/features/profile/services/models/userProfileModel.dart';
import 'package:akalpit/features/profile/services/profileActions.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

class ProfileViewModel {
  final bool isLoading;
  final String? error;
  final UserProfileModel? profile;
  final UserProfileModel? publicProfile;

  /// Actions
  final VoidCallback getMyProfile;
  final Function(String userId) getPublicProfile;
  final Function(Map<String, dynamic>, {XFile? imageFile}) createProfile;
  final Function(Map<String, dynamic>, {XFile? imageFile}) updateProfile;

  ProfileViewModel({
    required this.isLoading,
    this.error,
    this.profile,
    this.publicProfile,
    required this.getMyProfile,
    required this.getPublicProfile,
    required this.createProfile,
    required this.updateProfile,
  });

  static ProfileViewModel fromStore(Store<AppState> store) {
    final profileState = store.state.profileState;

    return ProfileViewModel(
      /// Use only profile-specific loading
      isLoading: profileState.isLoading,
      error: profileState.error,
      profile: profileState.profile,
      publicProfile: profileState.publicProfile,

      getMyProfile: () =>
          store.dispatch(GetMyProfileAction()),

      getPublicProfile: (String userId) =>
          store.dispatch(GetPublicProfileAction(userId)),

      createProfile: (Map<String, dynamic> data, {XFile? imageFile}) =>
          store.dispatch(CreateProfileAction(data, imageFile: imageFile)),

      updateProfile: (Map<String, dynamic> data, {XFile? imageFile}) =>
          store.dispatch(UpdateProfileAction(data, imageFile: imageFile)),
    );
  }

  /// Equality for StoreConnector(distinct: true)
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is ProfileViewModel &&
            isLoading == other.isLoading &&
            error == other.error &&
            profile == other.profile &&
            publicProfile == other.publicProfile;
  }

  @override
  int get hashCode =>
      Object.hash(isLoading, error, profile, publicProfile);
}
