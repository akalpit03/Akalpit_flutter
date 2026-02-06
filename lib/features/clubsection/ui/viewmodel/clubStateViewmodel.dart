import 'package:akalpit/core/store/app_state.dart';
import 'package:akalpit/features/clubProfile/services/states/clubs.dart';
import 'package:akalpit/features/clubsection/services/actions.dart';
import 'package:redux/redux.dart';

class ClubScreenViewModel {
  final Map<String, Club> byId;
  final List<Club> ownedClubs;
  final List<Club> followingClubs;
  final Club? activeClub;

  final String? myClubId;
  final Club? myClub;

  final bool isLoading;
  final String? error;

  final Function(String) setActiveClub;

  /// ✅ ADD THIS
  final Function(Map<String, dynamic>) submitCreateClub;

  ClubScreenViewModel({
    required this.byId,
    required this.ownedClubs,
    required this.followingClubs,
    required this.activeClub,
    required this.myClubId,
    required this.myClub,
    required this.isLoading,
    required this.error,
    required this.setActiveClub,
    required this.submitCreateClub,
  });

  static ClubScreenViewModel fromStore(Store<AppState> store) {
    final state = store.state.clubScreenState;

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

      ownedClubs: mapIdsToClubs(state.ownedClubIds),
      followingClubs: mapIdsToClubs(state.followingClubIds),

      activeClub: state.activeClubId != null
          ? state.byId[state.activeClubId]
          : null,

      myClubId: myClubId,
      myClub: myClubId != null ? state.byId[myClubId] : null,

      setActiveClub: (id) =>
          store.dispatch(SetActiveClubAction(id)),

      /// ✅ DISPATCH CREATE
      submitCreateClub: (data) =>
          store.dispatch(CreateClubRequestAction(data)),
    );
  }
}
