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
class CheckUsernameAvailabilityAction {
  final String username;
  CheckUsernameAvailabilityAction(this.username);
}

class CheckUsernameAvailabilitySuccessAction {
  final bool available;
  CheckUsernameAvailabilitySuccessAction(this.available);
}

class CheckUsernameAvailabilityFailureAction {
  final String error;
  CheckUsernameAvailabilityFailureAction(this.error);
}

class SearchProfilesFailureAction {
  final String error;

  SearchProfilesFailureAction(this.error);
}

class ClearProfileSearchAction {}
// features/club/store/club_availability_actions.dart

class CheckClubAvailabilityAction {
  final String clubId;

  CheckClubAvailabilityAction(this.clubId);
}

class CheckClubAvailabilitySuccessAction {
  final bool available;

  CheckClubAvailabilitySuccessAction(this.available);
}

class CheckClubAvailabilityFailureAction {
  final String error;

  CheckClubAvailabilityFailureAction(this.error);
}

class ClearClubAvailabilityAction {}
class ClearUsernameAvailabilityAction{}
// features/club_search/store/club_search_actions.dart

class SearchClubsAction {
  final String query;
  final int page;
  SearchClubsAction({required this.query, this.page = 1});
}

class SearchClubsSuccessAction {
  final List<dynamic> results;
  final Map<String, dynamic> pagination;
  SearchClubsSuccessAction(this.results, this.pagination);
}

class SearchClubsFailureAction {
  final String error;
  SearchClubsFailureAction(this.error);
}

class ClearClubSearchAction {}