import 'dart:io';
import 'package:akalpit/core/api/api_gateway.dart';
import 'package:akalpit/core/store/app_state.dart';
import 'package:akalpit/features/profile/services/models/friends/friendmodel.dart';
import 'package:akalpit/features/profile/services/models/incomoingRequests/request.dart';
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
    TypedMiddleware<AppState, UpdateProfileAction>(
      _handleUpdateProfile(apiGateway),
    ),
      TypedMiddleware<AppState, FetchIncomingRequestsAction>(
      _handleFetchIncomingRequests(apiGateway),
    ),TypedMiddleware<AppState, FetchMyFriendsAction>(
  _handleFetchMyFriends(apiGateway),
),

    TypedMiddleware<AppState, AcceptFriendRequestAction>(
  _handleAcceptFriendRequest(apiGateway),
  
),

TypedMiddleware<AppState, RejectFriendRequestAction>(
  _handleRejectFriendRequest(apiGateway),
),

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
      if (response == null) {
        store.dispatch(GetMyProfileSuccessAction(null));
      } else {
        final profile = UserProfileModel.fromJson(response["data"]);
        store.dispatch(GetMyProfileSuccessAction(profile));
      }
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
      final profileJson = await apiGateway.profileService
          .getPublicProfileByUserId(action.userId);

      final profile = UserProfileModel.fromJson(profileJson);

      store.dispatch(GetPublicProfileSuccessAction(profile));
    } catch (e) {
      store.dispatch(GetPublicProfileFailureAction(e.toString()));
    }
  };
}

Middleware<AppState> _handleFetchIncomingRequests(
    ApiGateway apiGateway,
) {
  return (Store<AppState> store, action, NextDispatcher next) async {
      if (action is FetchIncomingRequestsAction) {
   
 next(action); // 🔹 sets isRequestLoading = true

    try {
      final response =
          await apiGateway.profileService.getIncomingRequests();

      final requests = (response["data"] as List)
          .map((e) => IncomingRequest.fromJson(e))
          .toList();

      store.dispatch(
        FetchIncomingRequestsSuccessAction(requests),
      );
    } catch (e) {
      store.dispatch(
        FetchIncomingRequestsFailureAction(e.toString()),
      );
    }
       
    } else {
      next(action);
    }
  };
}
 
/// =======================
/// CREATE PROFILE
/// =======================
Middleware<AppState> _handleCreateProfile(ApiGateway apiGateway) {
  return (Store<AppState> store, action, NextDispatcher next) async {
    if (action is! CreateProfileAction) return next(action);
    
    next(action);

    try {
      final Map<String, dynamic> profileData = Map.from(action.profileData);

      // If there's an image, upload it first
      if (action.imageFile != null) {
        final imageUrl = await apiGateway.profileService.uploadProfileImage(action.imageFile!);
        profileData["imageUrl"] = imageUrl;
      }

      final response = await apiGateway.profileService.createProfile(profileData);
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
Middleware<AppState> _handleUpdateProfile(ApiGateway apiGateway) {
  return (Store<AppState> store, action, NextDispatcher next) async {
    if (action is! UpdateProfileAction) return next(action);

    next(action);

    try {
      final Map<String, dynamic> profileData = Map.from(action.profileData);

      // If there's an image, upload it first
      if (action.imageFile != null) {
        final imageUrl = await apiGateway.profileService.uploadProfileImage(action.imageFile!);
        profileData["imageUrl"] = imageUrl;
      }

      final response = await apiGateway.profileService.updateMyProfile(profileData);
      final profile = UserProfileModel.fromJson(response["data"]);

      store.dispatch(UpdateProfileSuccessAction(profile));
    } catch (e) {
      store.dispatch(UpdateProfileFailureAction(e.toString()));
    }
  };
}
Middleware<AppState> _handleAcceptFriendRequest(
    ApiGateway apiGateway,
) {
  return (store, action, next) async {
    if (action is AcceptFriendRequestAction) {
      next(action);

      try {
        print("Accepting friend request with id: ${action.requestId}");
        await apiGateway.profileService
            .acceptFriendRequest(action.requestId);

        store.dispatch(
          AcceptFriendRequestSuccessAction(
            action.requestId,
          ),
        );
      } catch (e) {
        store.dispatch(
          FetchIncomingRequestsFailureAction(
            e.toString(),
          ),
        );
      }
    } else {
      next(action);
    }
  };
}
Middleware<AppState> _handleRejectFriendRequest(
    ApiGateway apiGateway,
) {
  return (store, action, next) async {
    if (action is RejectFriendRequestAction) {
      next(action);

      try {
        await apiGateway.profileService
            .rejectFriendRequest(action.requestId);

        store.dispatch(
          RejectFriendRequestSuccessAction(
            action.requestId,
          ),
        );
      } catch (e) {
        store.dispatch(
          FetchIncomingRequestsFailureAction(
            e.toString(),
          ),
        );
      }
    } else {
      next(action);
    }
  };
}
Middleware<AppState> _handleFetchMyFriends(
  ApiGateway apiGateway,
) {
  return (store, action, next) async {
    if (action is FetchMyFriendsAction) {
      next(action); // sets loading = true

      try {
        final response = await apiGateway.profileService.getMyFriends();

        final friends = (response["data"] as List<dynamic>)
            .map((e) => FriendModel.fromJson(e))
            .toList(); // ✅ converts to List<FriendModel>

        store.dispatch(
          FetchMyFriendsSuccessAction(friends),
        );
      } catch (e) {
        store.dispatch(
          FetchMyFriendsFailureAction(e.toString()),
        );
      }
    } else {
      next(action);
    }
  };
}
