// Fetch Actions
class GetUpcomingEventsAction {
  final String clubId;
  GetUpcomingEventsAction(this.clubId);
}

class GetUpcomingEventsSuccessAction {
  final List<dynamic> events;
  GetUpcomingEventsSuccessAction(this.events);
}

// Create Actions
class CreateEventAction {
  final Map<String, dynamic> eventData;
  CreateEventAction(this.eventData);
}

class CreateEventSuccessAction {
  final dynamic newEvent;
  CreateEventSuccessAction(this.newEvent);
}

// Error Action
class ClubEventFailureAction {
  final String error;
  ClubEventFailureAction(this.error);
}