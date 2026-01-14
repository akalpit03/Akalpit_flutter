import 'package:akalpit/features/Events/activities/services/actions.dart';
import 'package:akalpit/features/Events/activities/services/state.dart';

ActivityState activityReducer(ActivityState state, action) {
 

  // 1. When the request STARTS
  if (action is GetEventScheduleAction) {
    return state.copyWith(isLoading: true, error: null);
  }

  // 2. When the request SUCCEEDS
  if (action is GetEventScheduleSuccessAction) {
 
    return state.copyWith(
      isLoading: false, // CRITICAL: Must be false
      eventSchedule: action.schedule,
    );
  }

  // 3. When the request FAILS (Important so spinner doesn't spin forever)
  if (action is ActivityErrorAction) {
    return state.copyWith(
      isLoading: false, 
      error: action.error
    );
  }

  if (action is GetActivityDetailsSuccessAction) {
    return state.copyWith(
      selectedActivity: action.activity,
      membersList: action.members,
      isLoading: false,
    );
  }

  return state;
}