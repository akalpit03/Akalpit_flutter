// features/profile_search/services/profile_search_actions.dart

class SearchProfilesAction {
  final String query;
  final int page;

  SearchProfilesAction({
    required this.query,
    this.page = 1,
  });
}

class SearchProfilesSuccessAction {
  final List<dynamic> results;
  final Map<String, dynamic> pagination;
  final String query;

  SearchProfilesSuccessAction({
    required this.results,
    required this.pagination,
    required this.query,
  });
}

class SearchProfilesFailureAction {
  final String error;

  SearchProfilesFailureAction(this.error);
}

class ClearProfileSearchAction {}
