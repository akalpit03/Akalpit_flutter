import 'package:akalpit/features/clubProfile/services/gettingClub/actions.dart';
 
import 'package:akalpit/features/clubsection/services/actions.dart';
import 'package:akalpit/features/clubsection/services/clubscreenstate.dart';

ClubScreenState clubScreenReducer(
  ClubScreenState state,
  dynamic action,
) {
  if (action is FetchMyClubByUserIdSuccessAction) {
    final club = action.club;

    return state.copyWith(
      byId: {
        ...state.byId,
        club.id: club,
      },
      myClubId: club.id,
      ownedClubIds: state.ownedClubIds.contains(club.id)
          ? state.ownedClubIds
          : [...state.ownedClubIds, club.id],
      error: null,
    );
  }

  if (action is FetchMyClubByUserIdFailureAction) {
    return state.copyWith(
      error: action.error,
    );
  }

  return state;
}
