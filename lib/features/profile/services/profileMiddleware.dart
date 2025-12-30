// features/profile/store/profile_middleware.dart
import 'package:akalpit/core/api/api_gateway.dart';
import 'package:akalpit/core/store/app_state.dart';
 
import 'package:akalpit/features/profile/services/models/userProfileModel.dart';
import 'package:akalpit/features/profile/services/profileActions.dart';
import 'package:redux/redux.dart';

List<Middleware<AppState>> profileMiddleware(ApiGateway apiGateway) {
  return [
    TypedMiddleware<AppState, GetMyProfileAction>(_handleGetProfile(apiGateway)),
    TypedMiddleware<AppState, CreateProfileAction>(_handleCreateProfile(apiGateway)),
  ];
}

Middleware<AppState> _handleGetProfile(ApiGateway apiGateway) {
  return (Store<AppState> store, action, NextDispatcher next) async {
    next(action); // Let reducer set loading = true
    try {
      final response = await apiGateway.profileService.getMyProfile();
      final profile = UserProfileModel.fromJson(response["data"]);
      store.dispatch(GetMyProfileSuccessAction(profile));
    } catch (e) {
      store.dispatch(GetMyProfileFailureAction(e.toString()));
    }
  };
}

Middleware<AppState> _handleCreateProfile(ApiGateway apiGateway) {
  return (Store<AppState> store, action, NextDispatcher next) async {
    next(action);
    try {
      final response = await apiGateway.profileService.createProfile(action.profileData);
      final profile = UserProfileModel.fromJson(response["data"]);
      store.dispatch(GetMyProfileSuccessAction(profile));
    } catch (e) {
      store.dispatch(GetMyProfileFailureAction(e.toString()));
    }
  };
}