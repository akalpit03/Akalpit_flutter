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
 
  if (action is FetchIncomingRequestsAction) {
    return state.copyWith(
      isRequestLoading: true,
      isRequestSuccess: false,
      requestError: null,
    );
  }

  if (action is FetchIncomingRequestsSuccessAction) {
    return state.copyWith(
      isRequestLoading: false,
      isRequestSuccess: true,
      incomingRequests: action.requests,
      requestError: null,
    );
  }

  if (action is FetchIncomingRequestsFailureAction) {
    return state.copyWith(
      isRequestLoading: false,
      isRequestSuccess: false,
      requestError: action.error,
    );
  }
 
 
if (action is AcceptFriendRequestSuccessAction ||
    action is RejectFriendRequestSuccessAction) {
  return state.copyWith(
    incomingRequests: state.incomingRequests
        .where((req) => req.id != action.requestId)
        .toList(),
  );
}

  if (action is GetMyProfileFailureAction) {
    return state.copyWith(
      isLoading: false,
      isSuccess: false,
      error: action.error,
    );
  }

if (action is GetPublicProfileSuccessAction) {
  return state.copyWith(
    isLoading: false,
    profile: action.profile,
    isSuccess: false,
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
if (action is FetchMyFriendsAction) {
  return state.copyWith(
    isFriendsLoading: true,
    isFriendsSuccess: false,
    friendsError: null,
  );
}

if (action is FetchMyFriendsSuccessAction) {
  return state.copyWith(
    isFriendsLoading: false,
    isFriendsSuccess: true,
    friends: action.friends,
    friendsError: null,
  );
}

if (action is FetchMyFriendsFailureAction) {
  return state.copyWith(
    isFriendsLoading: false,
    isFriendsSuccess: false,
    friendsError: action.error,
  );
}

  return state;
}
