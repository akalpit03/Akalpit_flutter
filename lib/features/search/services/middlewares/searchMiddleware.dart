import 'package:akalpit/core/api/api_gateway.dart';
import 'package:akalpit/core/store/app_state.dart';
import 'package:akalpit/features/search/services/actions/searchActions.dart';
import 'package:redux/redux.dart';

List<Middleware<AppState>> searchMiddleware(ApiGateway apiGateway) {
  return [
    TypedMiddleware<AppState, SearchProfilesAction>(
      searchProfiles(apiGateway),
    ),
    TypedMiddleware<AppState, CheckClubAvailabilityAction>(
      checkClubAvailability(apiGateway),
    ), 
        TypedMiddleware<AppState, SearchClubsAction>(
      clubSearchMiddleware(apiGateway),
    ),
  ];
}

Middleware<AppState> searchProfiles(ApiGateway apiGateway) {
  return (Store<AppState> store, action, NextDispatcher next) async {
    if (action is SearchProfilesAction) {
      next(action);

      try {
        final response = await apiGateway.profileSearchService.searchProfiles(
          query: action.query,
          page: action.page,
        );

        store.dispatch(SearchProfilesSuccessAction(
          query: action.query,
          results: response["results"],
          pagination: response["pagination"],
        ));
      } catch (e) {
        store.dispatch(
          SearchProfilesFailureAction(e.toString()),
        );
      }
    } else {
      next(action); 
    }
  };
}
 

Middleware<AppState> checkClubAvailability(ApiGateway apiGateway) {
  return (Store<AppState> store, action, NextDispatcher next) async {
    if (action is CheckClubAvailabilityAction) {
      next(action);

      try {
      print('Middleware: Checking availability for Club ID: ${action.clubId}');
        final response = await apiGateway.profileSearchService.checkclubAvailability(
          clubId: action.clubId,
        );

      

        final bool available = response["available"] as bool;
       print('available ${available}');

        store.dispatch(
          CheckClubAvailabilitySuccessAction(available),
        );
      } catch (e) {
        /// ❌ FAILURE ACTION (THIS ALSO STOPS LOADING)
        store.dispatch(
          CheckClubAvailabilityFailureAction(e.toString()),
        );
      }
    } else {
      next(action);
    }
  };
}

// features/club_search/store/club_search_middleware.dart

Middleware<AppState> clubSearchMiddleware(ApiGateway apiGateway) {
  return (Store<AppState> store, action, NextDispatcher next) async {
    if (action is SearchClubsAction) {
      next(action); // Let the reducer set isSearching = true

      try {
        final response = await apiGateway.profileSearchService.searchClubs(
          query: action.query,
          page: action.page,
        );

        store.dispatch(
          SearchClubsSuccessAction(
            response["results"],
            response["pagination"],
          ),
        );
      } catch (e) {
        store.dispatch(SearchClubsFailureAction(e.toString()));
      }
    } else {
      next(action);
    }
  };
}