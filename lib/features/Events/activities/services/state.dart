class ActivityState {
  final List<dynamic> eventSchedule;
  final dynamic selectedActivity;
  final List<dynamic> membersList;
  final bool isLoading;
  final String? error;

  ActivityState({
    this.eventSchedule = const [],
    this.selectedActivity,
    this.membersList = const [],
    this.isLoading = false,
    this.error,
  });

  // 1. Initial State Factory
  factory ActivityState.initial() {
    return ActivityState(
      eventSchedule: [],
      selectedActivity: null,
      membersList: [],
      isLoading: false,
      error: null,
    );
  }

  // 2. From JSON (Deserialization)
  factory ActivityState.fromJson(Map<String, dynamic>? json) {
    if (json == null) return ActivityState.initial();
    return ActivityState(
      eventSchedule: json['eventSchedule'] ?? [],
      selectedActivity: json['selectedActivity'],
      membersList: json['membersList'] ?? [],
      isLoading: false, // Usually reset loading to false on startup
      error: null,      // Reset errors on startup
    );
  }

  // 3. To JSON (Serialization)
  Map<String, dynamic> toJson() {
    return {
      'eventSchedule': eventSchedule,
      'selectedActivity': selectedActivity,
      'membersList': membersList,
      // We typically don't persist isLoading or error
    };
  }

  ActivityState copyWith({
    List<dynamic>? eventSchedule,
    dynamic selectedActivity,
    List<dynamic>? membersList,
    bool? isLoading,
    String? error,
  }) {
    return ActivityState(
      eventSchedule: eventSchedule ?? this.eventSchedule,
      selectedActivity: selectedActivity ?? this.selectedActivity,
      membersList: membersList ?? this.membersList,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}