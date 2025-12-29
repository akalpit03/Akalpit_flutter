 

import 'package:akalpit/features/search/services/actions/searchActions.dart';
import 'package:akalpit/features/search/services/searchProfileState.dart';

ProfileSearchState profileSearchReducer(
  ProfileSearchState state,
  dynamic action,
) {
  if (action is SearchProfilesAction) {
    return state.copyWith(
      isSearching: true,
      query: action.query,
      error: null,
      results: action.page == 1 ? [] : state.results,
    );
  }

  if (action is SearchProfilesSuccessAction) {
    final isFirstPage = action.pagination["page"] == 1;

    return state.copyWith(
      isSearching: false,
      query: action.query,
      results: isFirstPage
          ? action.results
          : [...state.results, ...action.results],
      pagination: action.pagination,
      error: null,
    );
  }

  if (action is SearchProfilesFailureAction) {
    return state.copyWith(
      isSearching: false,
      error: action.error,
    );
  }

  if (action is ClearProfileSearchAction) {
    return ProfileSearchState.initial();
  }

  return state;
}
