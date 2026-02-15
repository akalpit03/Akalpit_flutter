import 'dart:io';

import 'package:akalpit/core/api/api_gateway.dart';
import 'package:akalpit/core/store/app_state.dart';
import 'package:akalpit/features/clubProfile/services/clubactions/actions.dart';
import 'package:akalpit/features/clubProfile/services/models/post_data.dart';
import 'package:akalpit/features/clubProfile/services/states/clubstate.dart';
 

import 'package:redux/redux.dart';

List<Middleware<AppState>> clubMiddleware(ApiGateway apiGateway) {
  return [
    TypedMiddleware<AppState, GetClubAction>(
      _handleGetClub(apiGateway),
    ),
    TypedMiddleware<AppState, CreateClubPostAction>(
      _handleCreateClubPost(apiGateway),
    ), TypedMiddleware<AppState, FetchClubPostsByDateAction>(
      _handleFetchClubPostsByDate(apiGateway),
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

 Middleware<AppState> _handleCreateClubPost(
    ApiGateway apiGateway) {
  return (Store<AppState> store, action,
      NextDispatcher next) async {
    if (action is CreateClubPostAction) {
      next(action);

      try {
        final ClubPost post =
            await apiGateway.clubService
                .createClubPost(action.postData);

        store.dispatch(
            CreateClubPostSuccessAction(post));
      } catch (e) {
        store.dispatch(
            CreateClubPostFailureAction(e.toString()));
      }
    } else {
      next(action);
    }
  };
}
Middleware<AppState> _handleFetchClubPostsByDate(ApiGateway apiGateway) {
  return (Store<AppState> store, action, NextDispatcher next) async {
    if (action is FetchClubPostsByDateAction) {
      next(action);

      print("Fetching posts for clubId: ${action.clubId} on date: ${action.date}");

      try {
        final List<ClubPost> posts = await apiGateway.clubService.fetchClubPostsByDate(
          clubId: action.clubId,
          date: action.date,
        );

        print("Fetched ${posts.length} posts");

        store.dispatch(FetchClubPostsByDateSuccessAction(posts));
      } catch (e) {
        print("Error fetching posts: $e");
        store.dispatch(FetchClubPostsByDateFailureAction(e.toString()));
      }
    } else {
      next(action);
    }
  };
}


/// CREATE CLUB

