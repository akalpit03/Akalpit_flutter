import 'dart:io';
import 'package:akalpit/features/clubProfile/services/gettingClub/actions.dart';
import 'package:akalpit/features/clubProfile/services/gettingClub/state.dart';
import 'package:redux/redux.dart';

final clubReducer = combineReducers<ClubState>([
  /// ===== GET CLUB =====
  TypedReducer<ClubState, GetClubAction>(_getClub),
  TypedReducer<ClubState, GetClubSuccessAction>(_getClubSuccess),
  TypedReducer<ClubState, GetClubFailureAction>(_getClubFailure),

 
  TypedReducer<ClubState, ResetCreateClubAction>(_resetCreateClub),

  /// ===== IMAGE SELECT =====
  TypedReducer<ClubState, SelectClubImageAction>(_selectClubImage),
]);

/// ================= GET =================
ClubState _getClub(ClubState state, GetClubAction action) {
  return state.copyWith(
    isLoading: true,
    error: null,
  );
}

ClubState _getClubSuccess(ClubState state, GetClubSuccessAction action) {
  return state.copyWith(
    isLoading: false,
    club: action.club,
    error: null,
  );
}

ClubState _getClubFailure(ClubState state, GetClubFailureAction action) {
  return state.copyWith(
    isLoading: false,
    error: action.error,
  );
}

 
ClubState _resetCreateClub(ClubState state, ResetCreateClubAction action) {
  return state.copyWith(
    isLoading: false,
    error: null,
  );
}

/// ================= IMAGE SELECT =================
ClubState _selectClubImage(ClubState state, SelectClubImageAction action) {
  return state.copyWith(selectedImagePath: action.imagePath);
}
