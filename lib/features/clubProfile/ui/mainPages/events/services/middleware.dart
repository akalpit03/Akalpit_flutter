import 'package:akalpit/core/api/api_gateway.dart';
import 'package:akalpit/core/store/app_state.dart';
import 'package:akalpit/features/clubProfile/ui/mainPages/events/services/actions.dart';
import 'package:redux/redux.dart';

List<Middleware<AppState>> createEventMiddleware(ApiGateway apiGateway) {
  return [
    TypedMiddleware<AppState, GetUpcomingEventsAction>(
        _handleGetEvents(apiGateway)),
    TypedMiddleware<AppState, CreateEventAction>(
        _handleCreateEvent(apiGateway)),
  ];
}

Middleware<AppState> _handleGetEvents(ApiGateway apiGateway) {
  return (store, action, next) async {
    if (action is GetUpcomingEventsAction) {
      next(action);

      try {
        final Map<String, dynamic> response =
            await apiGateway.eventService.getEvents(action.clubId);

   

        final List<dynamic> events = response["data"] ?? [];

        store.dispatch(GetUpcomingEventsSuccessAction(events));
      } catch (e, stacktrace) {
        store.dispatch(ClubEventFailureAction(e.toString()));
      }
    } else {
      next(action);
    }
  };
}

Middleware<AppState> _handleCreateEvent(ApiGateway apiGateway) {
  return (store, action, next) async {
    next(action);
    try {
      final newEvent =
          await apiGateway.eventService.createEvent(action.eventData);
      store.dispatch(CreateEventSuccessAction(newEvent));
      // Optionally refresh the list after creation
    } catch (e) {
      store.dispatch(ClubEventFailureAction(e.toString()));
    }
  };
}
