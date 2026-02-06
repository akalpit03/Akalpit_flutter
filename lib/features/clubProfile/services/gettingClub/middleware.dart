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

 
/// CREATE CLUB

