// features/profile/store/profile_reducer.dart

import 'package:akalpit/features/profile/services/profileActions.dart';
import 'package:akalpit/features/profile/services/state/profileState.dart';

ProfileState profileReducer(ProfileState state, dynamic action) {
  /// ---------------- REQUESTS ----------------
  if (action is GetMyProfileAction ||
      action is GetPublicProfileAction || // 👈 ADDED
      action is CreateProfileAction ||
      action is UpdateProfileAction) {
    return state.copyWith(
      isLoading: true,
      isSuccess: false,
      error: null,
    );
  }

  /// ---------------- GET MY PROFILE ----------------
  if (action is GetMyProfileSuccessAction) {
    return state.copyWith(
      isLoading: false,
      profile: action.profile,
      isSuccess: false,
      error: null,
    );
  }

  if (action is GetMyProfileFailureAction) {
    return state.copyWith(
      isLoading: false,
      isSuccess: false,
      error: action.error,
    );
  }

  /// ---------------- GET PUBLIC PROFILE ----------------
  if (action is GetPublicProfileSuccessAction) {
    return state.copyWith(
      isLoading: false,
      profile: action.profile,
      isSuccess: false, // 👈 NO navigation
      error: null,
    );
  }

  if (action is GetPublicProfileFailureAction) {
    return state.copyWith(
      isLoading: false,
      isSuccess: false,
      error: action.error,
    );
  }

  /// ---------------- CREATE PROFILE ----------------
  if (action is CreateProfileSuccessAction) {
    return state.copyWith(
      isLoading: false,
      profile: action.profile,
      isSuccess: true, // navigation/snackbar
      error: null,
    );
  }

  if (action is CreateProfileFailureAction) {
    return state.copyWith(
      isLoading: false,
      isSuccess: false,
      error: action.error,
    );
  }

  /// ---------------- UPDATE PROFILE ----------------
  if (action is UpdateProfileSuccessAction) {
    return state.copyWith(
      isLoading: false,
      profile: action.profile,
      isSuccess: true, // navigation/snackbar
      error: null,
    );
  }

  if (action is UpdateProfileFailureAction) {
    return state.copyWith(
      isLoading: false,
      isSuccess: false,
      error: action.error,
    );
  }

  return state;
}
