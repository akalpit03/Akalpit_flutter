import 'package:akalpit/features/clubsection/services/actions.dart';
import 'package:akalpit/features/clubsection/services/clubscreenstate.dart';
import 'package:akalpit/features/clubsection/services/models/myclubs.dart';

ClubScreenState clubScreenReducer(
  ClubScreenState state,
  dynamic action,
) {
  // 1. Fetching user's owned club
if (action is FetchMyClubByUserIdSuccessAction) {
  final club = action.club;

  final myClubData = MyClub(
    id: club.id,
    clubName: club.clubName,
    clubImage: club.clubImage,
    myRole: club.myRole,
  );

  return state.copyWith(
    byId: {
      ...state.byId,
      myClubData.id: myClubData, // ✅ store MyClub
    },
    myClubId: myClubData.id,
    ownedClubIds: {
      ...state.ownedClubIds,
      myClubData.id: myClubData, // ✅ consistent type
    },
    error: null,
  );
}

  // 2. Creating a new club (which becomes an owned club)
if (action is CreateClubSuccessAction) {
  final club = action.club;

  final newOwnedClub = MyClub(
    id: club.id,
    clubName: club.clubName,
    clubImage: club.image,
    myRole: "owner", // newly created → owner
  );

  return state.copyWith(
    byId: {
      ...state.byId,
      newOwnedClub.id: newOwnedClub, // ✅ store MyClub
    },
    myClubId: newOwnedClub.id,
    ownedClubIds: {
      ...state.ownedClubIds,
      newOwnedClub.id: newOwnedClub,
    },
    isLoading: false,
    error: null,
  );
}

  if (action is FetchMyClubByUserIdFailureAction) {
    return state.copyWith(
      error: action.error,
    );
  }
if (action is GetMyClubsRequestAction) {
  return state.copyWith(
    isLoading: true,
    error: null,
  );
}

if (action is GetMyClubsSuccessAction) {
  return state.copyWith(
    ownedClubIds: action.owned,
    followingClubIds: action.following,
    isLoading: false,
    error: null,
  );
}

if (action is GetMyClubsFailureAction) {
  return state.copyWith(
    isLoading: false,
    error: action.error,
  );
}

  return state;
}