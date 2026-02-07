import 'package:akalpit/core/store/app_state.dart';
import 'package:akalpit/features/clubsection/services/actions.dart';
import 'package:akalpit/features/clubsection/services/models/myclubs.dart';
import 'package:redux/redux.dart';

class ClubScreenViewModel {
  final Map<String, MyClub> byId;

  final Map<String, MyClub> ownedClubs;
  final Map<String, MyClub> followingClubs;

  final MyClub? activeClub;

  final String? myClubId;
  final MyClub? myClub;

  final bool isLoading;
  final String? error;

  final Function(String) setActiveClub;
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

    final String? myClubId = state.myClubId;

    return ClubScreenViewModel(
      byId: state.byId, // ✅ MyClub map
      isLoading: state.isLoading,
      error: state.error,

      ownedClubs: state.ownedClubIds,
      followingClubs: state.followingClubIds,

      /// ✅ Active Club now MyClub
      activeClub: state.activeClubId != null
          ? state.byId[state.activeClubId]
          : null,

      myClubId: myClubId,

      /// ✅ Fetch from owned or following
      myClub: myClubId != null
          ? state.byId[myClubId] ??
              state.followingClubIds[myClubId]
          : null,

      setActiveClub: (id) =>
          store.dispatch(SetActiveClubAction(id)),

      submitCreateClub: (data) =>
          store.dispatch(CreateClubRequestAction(data)),
    );
  }
}
