import 'package:akalpit/features/clubsection/services/actions.dart';
import 'package:redux/redux.dart';
import 'package:akalpit/core/store/app_state.dart';
import 'package:akalpit/features/clubProfile/services/states/clubs.dart';

class ClubScreenViewModel {
  // 1. The full data map
  final Map<String, Club> byId;

  // 2. Computed Lists
  final List<Club> ownedClubs;
  final List<Club> followingClubs;

  // 3. Clubs derived from IDs
  final Club? activeClub;

  /// ✅ NEW: my club (from myClubId)
  final String? myClubId;
  final Club? myClub;

  // 4. Loading/Error states
  final bool isLoading;
  final String? error;

  // 5. Actions
  final Function(String) setActiveClub;

  ClubScreenViewModel({
    required this.byId,
    required this.ownedClubs,
    required this.followingClubs,
    required this.activeClub,
    required this.myClubId,
    required this.myClub,
    required this.isLoading,
    this.error,
    required this.setActiveClub,
  });

  static ClubScreenViewModel fromStore(Store<AppState> store) {
    final state = store.state.clubScreenState;

    // Helper: map IDs → Club objects safely
    List<Club> mapIdsToClubs(List<String> ids) {
      return ids
          .map((id) => state.byId[id])
          .whereType<Club>()
          .toList();
    }

    final String? myClubId = state.myClubId;

    return ClubScreenViewModel(
      byId: state.byId,
      isLoading: state.isLoading,
      error: state.error,

      // Lists
      ownedClubs: mapIdsToClubs(state.ownedClubIds),
      followingClubs: mapIdsToClubs(state.followingClubIds),

      // Active club
      activeClub: state.activeClubId != null
          ? state.byId[state.activeClubId]
          : null,

      // ✅ My club
      myClubId: myClubId,
      myClub: myClubId != null ? state.byId[myClubId] : null,

      // Actions
      setActiveClub: (id) => store.dispatch(SetActiveClubAction(id)),
    );
  }
}
