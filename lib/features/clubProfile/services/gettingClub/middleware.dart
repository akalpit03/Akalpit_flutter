import 'dart:io';

import 'package:akalpit/core/api/api_gateway.dart';
import 'package:akalpit/core/store/app_state.dart';
import 'package:akalpit/features/clubProfile/services/gettingClub/actions.dart';
import 'package:akalpit/features/clubProfile/services/states/clubs.dart';
 

import 'package:redux/redux.dart';

List<Middleware<AppState>> clubMiddleware(ApiGateway apiGateway) {
  return [
    TypedMiddleware<AppState, GetClubAction>(
      _handleGetClub(apiGateway),
    ),
    TypedMiddleware<AppState, SubmitCreateClubAction>(
      _handleClubImageUpload(apiGateway),
    ),
    TypedMiddleware<AppState, CreateClubAction>(
      _handleCreateClub(apiGateway),
    ),
  ];
}

Middleware<AppState> _handleGetClub(ApiGateway apiGateway) {
  return (Store<AppState> store, action, NextDispatcher next) async {
    if (action is GetClubAction) {
      next(action);

      try {
        // ✅ This now returns Club
        final Club club =
            await apiGateway.clubService.getClubDetails(action.clubId);

        // ✅ Dispatch Club, not Map
        store.dispatch(GetClubSuccessAction(club));
      } catch (e) {
        store.dispatch(GetClubFailureAction(e.toString()));
      }
    } else {
      next(action);
    }
  };
}

Middleware<AppState> _handleClubImageUpload(ApiGateway apiGateway) {
  return (Store<AppState> store, action, NextDispatcher next) async {
    if (action is SubmitCreateClubAction) {
      next(action); // let loading state update if needed

      try {
        String? imageUrl;

        final imageFile = store.state.clubState.selectedImagePath != null
            ? File(store.state.clubState.selectedImagePath!)
            : null;

        // Upload only if image exists
        if (imageFile != null) {
          imageUrl =
              await apiGateway.clubService.uploadClubImage(imageFile);
        }

        // Merge image URL into club data
        final updatedData = {
          ...action.clubData,
          if (imageUrl != null) "image": imageUrl,
        };

        // 🔥 Pass to next middleware
        store.dispatch(CreateClubAction(updatedData));
      } catch (e) {
        store.dispatch(
          CreateClubFailureAction("Image upload failed"),
        );
      }
    } else {
      next(action);
    }
  };
}

/// CREATE CLUB
Middleware<AppState> _handleCreateClub(ApiGateway apiGateway) {
  return (Store<AppState> store, action, NextDispatcher next) async {
    if (action is CreateClubAction) {
      next(action);
      try {
        final response =
            await apiGateway.clubService.createClub(action.clubData);

        final club = Club.fromJson(response["data"]);

        store.dispatch(CreateClubSuccessAction(club));
      } catch (e) {
        store.dispatch(CreateClubFailureAction(e.toString()));
      }
    } else {
      next(action);
    }
  };
}
