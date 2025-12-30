 

import 'package:akalpit/features/profile/services/profileActions.dart';
import 'package:akalpit/features/profile/services/profileState.dart';

ProfileState profileReducer(ProfileState state, dynamic action) {
  if (action is GetMyProfileAction || action is CreateProfileAction) {
    return state.copyWith(isLoading: true, error: null);
  }

  if (action is GetMyProfileSuccessAction) {
    return state.copyWith(
      isLoading: false,
      profile: action.profile,
      error: null,
    );
  }

  if (action is GetMyProfileFailureAction) {
    return state.copyWith(
      isLoading: false,
      error: action.error,
    );
  }

  return state;
}