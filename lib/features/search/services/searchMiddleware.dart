import 'package:akalpit/core/api/api_gateway.dart';
import 'package:akalpit/core/store/app_state.dart';
import 'package:akalpit/features/search/services/searchActions.dart';
import 'package:redux/redux.dart';

List<Middleware<AppState>> searchMiddleware(ApiGateway apiGateway) {
  return [
    TypedMiddleware<AppState, SearchProfilesAction>(
      searchProfiles(apiGateway),
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
