import 'package:akalpit/features/clubProfile/ui/mainPages/events/services/actions.dart';
import 'package:akalpit/features/clubProfile/ui/mainPages/events/services/state.dart';
import 'package:redux/redux.dart';

final clubEventReducer = combineReducers<ClubEventState>([
  TypedReducer<ClubEventState, GetUpcomingEventsAction>(_setFetchLoading),
  TypedReducer<ClubEventState, GetUpcomingEventsSuccessAction>(_getEventsSuccess),
  TypedReducer<ClubEventState, CreateEventAction>(_setCreateLoading),
  TypedReducer<ClubEventState, CreateEventSuccessAction>(_createEventSuccess),
  TypedReducer<ClubEventState, ClubEventFailureAction>(_setFailure),
]);

ClubEventState _setFetchLoading(ClubEventState state, dynamic action) =>
    state.copyWith(isLoading: true, error: null);

ClubEventState _setCreateLoading(ClubEventState state, dynamic action) =>
    state.copyWith(isCreating: true, error: null);

ClubEventState _getEventsSuccess(ClubEventState state, GetUpcomingEventsSuccessAction action) {
 
  return state.copyWith(
    isLoading: false, 
    events: action.events,
  );
}
ClubEventState _createEventSuccess(ClubEventState state, CreateEventSuccessAction action) =>
    state.copyWith(isCreating: false, events: [action.newEvent, ...state.events]);

ClubEventState _setFailure(ClubEventState state, ClubEventFailureAction action) =>
    state.copyWith(isLoading: false, isCreating: false, error: action.error);