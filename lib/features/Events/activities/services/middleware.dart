import 'package:akalpit/core/api/api_gateway.dart';
import 'package:akalpit/core/store/app_state.dart';
import 'package:akalpit/features/Events/activities/services/actions.dart';
import 'package:redux/redux.dart';

List<Middleware<AppState>> activityMiddleware(ApiGateway apiGateway) {
  return [
    TypedMiddleware<AppState, GetEventScheduleAction>(
      _handleGetEventSchedule(apiGateway),
    ),
    TypedMiddleware<AppState, GetActivityDetailsAction>(
      _handleGetActivityDetails(apiGateway),
    ),
  ];
}

/* ---------------- Get Grouped Schedule ---------------- */
Middleware<AppState> _handleGetEventSchedule(ApiGateway apiGateway) {
  return (Store<AppState> store, action, NextDispatcher next) async {
    if (action is GetEventScheduleAction) {
      next(action); // Let reducer set isLoading = true

      try {
        // Matches: router.get('/:eventId/schedule', getEventSchedule);
        print("done");
        final response =
            await apiGateway.activityService.fetchSchedule(action.eventId);

        final List<dynamic> schedule = response["data"];
      
        store.dispatch(GetEventScheduleSuccessAction(schedule));
      } catch (e) {
        store.dispatch(ActivityErrorAction(e.toString()));
      }
    } else {
      next(action);
    }
  };
}

/* ---------------- Get Specific Activity Details ---------------- */
Middleware<AppState> _handleGetActivityDetails(ApiGateway apiGateway) {
  return (Store<AppState> store, action, NextDispatcher next) async {
    next(action); // Let reducer set isLoading = true

    try {
      // Matches: router.get("/:eventId/days/:dayId", getActivityById);
      // final response = await apiGateway.activityService
      // .getActivityById(action.eventId, action.activityId);

      // final activityData = response["data"];

      // Assuming members list is returned inside activity data or a separate field
      // final members = activityData["membersList"] ?? [];
//
      // store.dispatch(GetActivityDetailsSuccessAction(
      // activity: activityData,
      // members: members,
      // ));
    } catch (e) {
      // store.dispatch(GetActivityDetailsFailureAction(e.toString()));
    }
  };
}
