import 'package:akalpit/features/clubsection/services/actions.dart';
import 'package:akalpit/features/clubsection/services/models/myclubs.dart';
import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:akalpit/core/api/api_gateway.dart';
import 'package:akalpit/core/store/app_state.dart';
 
import 'package:akalpit/features/clubProfile/services/states/clubstate.dart';
 
List<Middleware<AppState>> myClubMiddleware(ApiGateway apiGateway) {
  return [
    TypedMiddleware<AppState, FetchMyClubByUserIdAction>(
      _handleFetchMyClub(apiGateway),
        ), TypedMiddleware<AppState, CreateClubRequestAction>(
          _handleCreateClub(apiGateway),
        ),
    TypedMiddleware<AppState, GetMyClubsRequestAction>(
      handleGetMyClubs(apiGateway),)
  ];
}
Middleware<AppState> _handleFetchMyClub(ApiGateway apiGateway) {
  return (Store<AppState> store, action, NextDispatcher next) async {

    if (action is FetchMyClubByUserIdAction) {
      next(action); // pass action to reducer first

      try {
        final MyClub? club =
            await apiGateway.clubMembershipService.fetchClubByUserId();

        if (club == null) {
          return;
        }

        // ✅ Save to SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('myClubId', club.id);

        // ✅ Dispatch success
        store.dispatch(
          FetchMyClubByUserIdSuccessAction(club),
        );
      } catch (e) {
        store.dispatch(
          FetchMyClubByUserIdFailureAction(e.toString()),
        );
      }

    } else {
      next(action); // only forward other actions
    }
  };
}


Middleware<AppState> _handleCreateClub(ApiGateway apiGateway) {
  return (Store<AppState> store, action, NextDispatcher next) async {
    if (action is CreateClubRequestAction) {
      next(action);

      try {
        final club =
            await apiGateway.clubSectionService.createClub(action.data);

        store.dispatch(CreateClubSuccessAction(club));
      } catch (e) {
        store.dispatch(CreateClubFailureAction(e.toString()));
      }
    } else {
      next(action);
    }
  };
}
Middleware<AppState> handleGetMyClubs(ApiGateway apiGateway) {
  return (Store<AppState> store, action, NextDispatcher next) async {
    if (action is GetMyClubsRequestAction) {
      next(action);

      try {
        final clubs =
            await apiGateway.clubSectionService.getMyClubs();

        final Map<String, MyClub> owned = {};
        final Map<String, MyClub> following = {};

        for (final club in clubs) {
          if (club.myRole == "admin") {
            owned[club.id] = club;
          } else {
            following[club.id] = club;
          }
        }

        store.dispatch(
          GetMyClubsSuccessAction(
            owned: owned,
            following: following,
          ),
        );
      } catch (e) {
        store.dispatch(
          GetMyClubsFailureAction(e.toString()),
        );
      }
    } else {
      next(action);
    }
  };
}
