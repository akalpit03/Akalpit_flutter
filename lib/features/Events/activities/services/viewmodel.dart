// viewmodel.dart
import 'package:akalpit/core/store/app_state.dart';
import 'package:akalpit/features/Events/activities/services/actions.dart';
import 'package:redux/redux.dart';

class ActivityViewModel {
  final List<dynamic> schedule;
  final bool isLoading;
  final Function(String) getSchedule;
  final Function(String, String) loadActivity;

  ActivityViewModel({
    required this.schedule,
    required this.isLoading,
    required this.getSchedule,
    required this.loadActivity,
  });

  static ActivityViewModel fromStore(Store<AppState> store) {
    return ActivityViewModel(
      schedule: store.state.activityState.eventSchedule,
      isLoading: store.state.activityState.isLoading,
      getSchedule: (eventId) => store.dispatch(GetEventScheduleAction(eventId)),
      loadActivity: (eventId, actId) => store.dispatch(GetActivityDetailsAction(eventId, actId)),
    );
  }
}