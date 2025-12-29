// features/club/store/club_availability_state.dart

class ClubAvailabilityState {
  final bool isChecking;
  final bool? available;
  final String? error;

  const ClubAvailabilityState({
    this.isChecking = false,
    this.available,
    this.error,
  });

  factory ClubAvailabilityState.initial() {
    return const ClubAvailabilityState();
  }

  ClubAvailabilityState copyWith({
    bool? isChecking,
    bool? available,
    String? error,
  }) {
    return ClubAvailabilityState(
      isChecking: isChecking ?? this.isChecking,
      available: available,
      error: error,
    );
  }

  /// 📦 Serialize
  Map<String, dynamic> toJson() {
    return {
      "isChecking": isChecking,
      "available": available,
      "error": error,
    };
  }

  /// 📥 Deserialize
  factory ClubAvailabilityState.fromJson(Map<String, dynamic> json) {
    return ClubAvailabilityState(
      isChecking: json["isChecking"] ?? false,
      available: json.containsKey("available")
          ? json["available"] as bool?
          : null,
      error: json["error"],
    );
  }
}
