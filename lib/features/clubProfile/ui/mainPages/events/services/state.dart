class ClubEventState {
  final bool isLoading;
  final bool isCreating;
  final String? error;
  final List<dynamic> events;

  ClubEventState({
    this.isLoading = false,
    this.isCreating = false,
    this.error,
    this.events = const [],
  });

  /// =====================
  /// Initial State
  /// =====================
  factory ClubEventState.initial() {
    return ClubEventState(
      isLoading: false,
      isCreating: false,
      error: null,
      events: [],
    );
  }

  /// =====================
  /// Copy With
  /// =====================
  ClubEventState copyWith({
    bool? isLoading,
    bool? isCreating,
    String? error,
    List<dynamic>? events,
  }) {
    return ClubEventState(
      isLoading: isLoading ?? this.isLoading,
      isCreating: isCreating ?? this.isCreating,
      error: error, // Error is usually cleared on new actions, so we don't null-check
      events: events ?? this.events,
    );
  }

  /// =====================
  /// From JSON
  /// =====================
  factory ClubEventState.fromJson(Map<String, dynamic> json) {
    return ClubEventState(
      isLoading: json['isLoading'] ?? false,
      isCreating: json['isCreating'] ?? false,
      error: json['error'],
      events: json['events'] ?? [],
    );
  }

  /// =====================
  /// To JSON
  /// =====================
  Map<String, dynamic> toJson() {
    return {
      'isLoading': isLoading,
      'isCreating': isCreating,
      'error': error,
      'events': events,
    };
  }
}