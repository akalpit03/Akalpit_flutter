// features/club_search/store/club_search_reducer.dart

import 'package:akalpit/features/search/services/actions/searchActions.dart';
import 'package:akalpit/features/search/services/state/searchClubState.dart';

ClubSearchState clubSearchReducer(ClubSearchState state, dynamic action) {
  if (action is SearchClubsAction) {
    return state.copyWith(isSearching: true, query: action.query, error: null);
  }

  if (action is SearchClubsSuccessAction) {
    return state.copyWith(
      isSearching: false,
      results: action.results,
      pagination: action.pagination,
    );
  }

  if (action is SearchClubsFailureAction) {
    return state.copyWith(isSearching: false, error: action.error);
  }

  if (action is ClearClubSearchAction) {
    return ClubSearchState.initial();
  }

  return state;
}