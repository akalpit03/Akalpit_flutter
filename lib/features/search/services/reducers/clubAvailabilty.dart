 
import 'package:akalpit/features/search/services/actions/searchActions.dart';
import 'package:akalpit/features/search/services/state/clubAvailability.dart';

ClubAvailabilityState clubAvailabilityReducer(
  ClubAvailabilityState state,
  dynamic action,
) {
  if (action is CheckClubAvailabilityAction) {
    return state.copyWith(
      isChecking: true,
      available: null,
      error: null,
    );
  }

  if (action is CheckClubAvailabilitySuccessAction) {
    return state.copyWith(
      isChecking: false,
      available: action.available,
      error: null,
    );
  }

  if (action is CheckClubAvailabilityFailureAction) {
    return state.copyWith(
      isChecking: false,
      available: null,
      error: action.error,
    );
  }

  if (action is ClearClubAvailabilityAction) {
    return ClubAvailabilityState.initial();
  }

  return state;
}
