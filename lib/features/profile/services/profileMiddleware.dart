// features/profile/store/profile_middleware.dart
import 'package:akalpit/core/api/api_gateway.dart';
import 'package:akalpit/core/store/app_state.dart';
import 'package:akalpit/features/profile/services/models/userProfileModel.dart';
import 'package:akalpit/features/profile/services/profileActions.dart';
import 'package:redux/redux.dart';

List<Middleware<AppState>> profileMiddleware(ApiGateway apiGateway) {
  return [
    TypedMiddleware<AppState, GetMyProfileAction>(
      _handleGetProfile(apiGateway),
    ),
    TypedMiddleware<AppState, CreateProfileAction>(
      _handleCreateProfile(apiGateway),
    ),
     TypedMiddleware<AppState, GetPublicProfileAction>( // 👈 ADDED
      _handleGetPublicProfile(apiGateway),
    ),
    // TypedMiddleware<AppState, UpdateProfileAction>(
    //   _handleUpdateProfile(apiGateway),
    // ),
  ];
}

/// =======================
/// GET PROFILE
/// =======================
Middleware<AppState> _handleGetProfile(ApiGateway apiGateway) {
  return (Store<AppState> store, action, NextDispatcher next) async {
    next(action); // sets loading = true

    try {
      final response = await apiGateway.profileService.getMyProfile();
      final profile = UserProfileModel.fromJson(response["data"]);
      store.dispatch(GetMyProfileSuccessAction(profile));
    } catch (e) {
      store.dispatch(GetMyProfileFailureAction(e.toString()));
    }
  };
}
/// =======================
/// GET PUBLIC PROFILE
/// =======================
Middleware<AppState> _handleGetPublicProfile(ApiGateway apiGateway) {
  return (Store<AppState> store, action, NextDispatcher next) async {
    next(action); // sets loading = true

    try {
      final response = await apiGateway.profileService
          .getPublicProfileByUserId(action.userId);

      final profile = UserProfileModel.fromJson(response["data"]);

      store.dispatch(GetPublicProfileSuccessAction(profile));
    } catch (e) {
      store.dispatch(GetPublicProfileFailureAction(e.toString()));
    }
  };
}

/// =======================
/// CREATE PROFILE
/// =======================
Middleware<AppState> _handleCreateProfile(ApiGateway apiGateway) {
  return (Store<AppState> store, action, NextDispatcher next) async {
    next(action);

    try {
      final response = await apiGateway.profileService
          .createProfile(action.profileData);

      final profile = UserProfileModel.fromJson(response["data"]);

      store.dispatch(CreateProfileSuccessAction(profile));
    } catch (e) {
      store.dispatch(CreateProfileFailureAction(e.toString()));
    }
  };
}

/// =======================
/// UPDATE PROFILE
/// =======================
// Middleware<AppState> _handleUpdateProfile(ApiGateway apiGateway) {
//   return (Store<AppState> store, action, NextDispatcher next) async {
//     next(action);

//     try {
//       final response = await apiGateway.profileService
//           .updateProfile(action.profileData);

//       final profile = UserProfileModel.fromJson(response["data"]);

//       store.dispatch(UpdateProfileSuccessAction(profile));
//     } catch (e) {
//       store.dispatch(UpdateProfileFailureAction(e.toString()));
//     }
//   };
// }
