// features/profile/viewmodels/profile_viewmodel.dart

import 'package:akalpit/core/store/app_state.dart';
import 'package:akalpit/features/profile/services/models/userProfileModel.dart';
import 'package:akalpit/features/profile/services/profileActions.dart';
 
import 'package:redux/redux.dart';

class ProfileViewModel {
  final bool isLoading;
  final String? error;
  final UserProfileModel? profile;
  
  // Functions to trigger actions
  final Function() getProfile;
  final Function(Map<String, dynamic>) createProfile;

  ProfileViewModel({
    required this.isLoading,
    this.error,
    this.profile,
    required this.getProfile,
    required this.createProfile,
  });

  static ProfileViewModel fromStore(Store<AppState> store) {
    return ProfileViewModel(
      isLoading: store.state.profileState.isLoading,
      error: store.state.profileState.error,
      profile: store.state.profileState.profile,
      
      getProfile: () {
        store.dispatch(GetMyProfileAction());
      },
      
      createProfile: (Map<String, dynamic> data) {
        store.dispatch(CreateProfileAction(data));
      },
    );
  }
}