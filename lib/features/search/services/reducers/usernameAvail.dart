 
import 'package:akalpit/features/search/services/actions/searchActions.dart';
import 'package:akalpit/features/search/services/state/usernameAvailability.dart';

UsernameAvailabilityState usernameAvailabilityReducer(
  UsernameAvailabilityState state,
  dynamic action,
) {
  if (action is CheckUsernameAvailabilityAction) {
    return state.copyWith(
      isChecking: true,
      available: null,
      error: null,
    );
  }

  if (action is CheckUsernameAvailabilitySuccessAction) {
    return state.copyWith(
      isChecking: false,
      available: action.available,
      error: null,
    );
  }

  if (action is CheckUsernameAvailabilityFailureAction) {
    return state.copyWith(
      isChecking: false,
      available: null,
      error: action.error,
    );
  }

  if (action is ClearUsernameAvailabilityAction) {
    return UsernameAvailabilityState.initial();
  }

  return state;
}
