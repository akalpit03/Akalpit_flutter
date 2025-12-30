// features/profile_search/viewmodel/profile_search_viewmodel.dart

import 'package:akalpit/features/search/services/actions/searchActions.dart';
import 'package:akalpit/features/search/services/state/searchProfileState.dart';
import 'package:flutter/foundation.dart';
import 'package:redux/redux.dart';

import '../../../core/store/app_state.dart';
 

class ProfileSearchViewModel {
  final bool isSearching;
  final String query;
  final List<dynamic> results;
  final Map<String, dynamic>? pagination;
  final String? error;

  final VoidCallback clear;
  final void Function(String query) search;
  final VoidCallback loadNextPage;

  ProfileSearchViewModel({
    required this.isSearching,
    required this.query,
    required this.results,
    required this.pagination,
    required this.error,
    required this.search,
    required this.loadNextPage,
    required this.clear,
  });

  static ProfileSearchViewModel fromStore(Store<AppState> store) {
    final ProfileSearchState state = store.state.profileSearchState;

    return ProfileSearchViewModel(
      isSearching: state.isSearching,
      query: state.query,
      results: state.results,
      pagination: state.pagination,
      error: state.error,

      /// 🔍 Start new search
      search: (String query) {
        if (query.trim().isEmpty) return;

        store.dispatch(
          SearchProfilesAction(query: query, page: 1),
        );
      },

      /// 📄 Load next page (infinite scroll safe)
      loadNextPage: () {
        if (state.isSearching) return;

        final pagination = state.pagination;
        if (pagination == null) return;

        final hasNextPage = pagination["hasNextPage"] == true;
        if (!hasNextPage) return;

        final nextPage = (pagination["page"] ?? 1) + 1;

        store.dispatch(
          SearchProfilesAction(
            query: state.query,
            page: nextPage,
          ),
        );
      },

      /// 🧹 Clear search state
      clear: () {
        store.dispatch(ClearProfileSearchAction());
      },
    );
  }
}
