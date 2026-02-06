import 'package:akalpit/features/clubsection/services/actions.dart';
import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:akalpit/core/api/api_gateway.dart';
import 'package:akalpit/core/store/app_state.dart';
 
import 'package:akalpit/features/clubProfile/services/states/clubs.dart';
 
List<Middleware<AppState>> myClubMiddleware(ApiGateway apiGateway) {
  return [
    TypedMiddleware<AppState, FetchMyClubByUserIdAction>(
      _handleFetchMyClub(apiGateway),
    ), TypedMiddleware<AppState, CreateClubRequestAction>(
      _handleCreateClub(apiGateway),
    ),
  ];
}

Middleware<AppState> _handleFetchMyClub(ApiGateway apiGateway) {
  return (Store<AppState> store, action, NextDispatcher next) async {
    next(action);

    try {
      final Club? club =
          await apiGateway.clubMembershipService.fetchClubByUserId();

      if (club == null) {
        return; // user does not own any club
      }

      /// ✅ Save to SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('myClubId', club.id);

      /// ✅ Update redux
      store.dispatch(
        FetchMyClubByUserIdSuccessAction(club),
      );
    } catch (e) {
      store.dispatch(
        FetchMyClubByUserIdFailureAction(e.toString()),
      );
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
