// actions.dart
class GetEventScheduleAction {
  final String eventId;
  GetEventScheduleAction(this.eventId);
}

class GetEventScheduleSuccessAction {
  final List<dynamic> schedule;
  GetEventScheduleSuccessAction(this.schedule);
}

class GetActivityDetailsAction {
  final String eventId;
  final String activityId;
  GetActivityDetailsAction(this.eventId, this.activityId);
}

class GetActivityDetailsSuccessAction {
  final dynamic activity;
  final List<dynamic> members;
  GetActivityDetailsSuccessAction(this.activity, this.members);
}

class ActivityErrorAction {
  final String error;
  ActivityErrorAction(this.error);
}