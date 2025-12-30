// features/club_search/viewmodels/ClubSearchViewModel.dart

import 'package:akalpit/core/store/app_state.dart';
import 'package:akalpit/features/search/services/actions/searchActions.dart';
import 'package:redux/redux.dart';

class ClubSearchViewModel {
  final bool isSearching;
  final List<dynamic> clubs;
  final String? error;
  final Function(String) onSearch;
  final Function() onClear;

  ClubSearchViewModel({
    required this.isSearching,
    required this.clubs,
    this.error,
    required this.onSearch,
    required this.onClear,
  });

  static ClubSearchViewModel fromStore(Store<AppState> store) {
    return ClubSearchViewModel(
      isSearching: store.state.clubSearchState.isSearching,
      clubs: store.state.clubSearchState.results,
      error: store.state.clubSearchState.error,
      onSearch: (query) => store.dispatch(SearchClubsAction(query: query)),
      onClear: () => store.dispatch(ClearClubSearchAction()),
    );
  }
}