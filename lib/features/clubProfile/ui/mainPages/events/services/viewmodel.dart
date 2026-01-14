import 'package:akalpit/core/store/app_state.dart';
import 'package:akalpit/features/clubProfile/ui/mainPages/events/services/actions.dart';
import 'package:redux/redux.dart';

class ClubEventViewModel {
  final bool isLoading;
  final bool isCreating;
  final String? error;
  final List<dynamic> events;

  final Function(String clubId) getEvents;
  final Function(Map<String, dynamic> data) createEvent;

  ClubEventViewModel({
    required this.isLoading,
    required this.isCreating,
    required this.error,
    required this.events,
    required this.getEvents,
    required this.createEvent,
  });

  factory ClubEventViewModel.fromStore(Store<AppState> store) {
    final state = store.state.clubEventState;
    return ClubEventViewModel(
      isLoading: state.isLoading,
      isCreating: state.isCreating,
      error: state.error,
      events: state.events,
      getEvents: (clubId) => store.dispatch(GetUpcomingEventsAction(clubId)),
      createEvent: (data) => store.dispatch(CreateEventAction(data)),
    );
  }
}