class UsernameAvailabilityState {
  final bool isChecking;
  final bool? available;
  final String? error;

  const UsernameAvailabilityState({
    this.isChecking = false,
    this.available,
    this.error,
  });

  factory UsernameAvailabilityState.initial() {
    return const UsernameAvailabilityState();
  }

  UsernameAvailabilityState copyWith({
    bool? isChecking,
    bool? available,
    String? error,
  }) {
    return UsernameAvailabilityState(
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
  factory UsernameAvailabilityState.fromJson(Map<String, dynamic> json) {
    return UsernameAvailabilityState(
      isChecking: json["isChecking"] ?? false,
      available: json.containsKey("available")
          ? json["available"] as bool?
          : null,
      error: json["error"],
    );
  }
}
