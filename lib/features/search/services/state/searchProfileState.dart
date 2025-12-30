// features/profile_search/store/profile_search_state.dart

class ProfileSearchState {
  final bool isSearching;
  final String query;
  final List<dynamic> results;
  final Map<String, dynamic>? pagination;
  final String? error;

  const ProfileSearchState({
    this.isSearching = false,
    this.query = "",
    this.results = const [],
    this.pagination,
    this.error,
  });

  factory ProfileSearchState.initial() {
    return const ProfileSearchState();
  }

  /// 🔄 Copy
  ProfileSearchState copyWith({
    bool? isSearching,
    String? query,
    List<dynamic>? results,
    Map<String, dynamic>? pagination,
    String? error,
  }) {
    return ProfileSearchState(
      isSearching: isSearching ?? this.isSearching,
      query: query ?? this.query,
      results: results ?? this.results,
      pagination: pagination ?? this.pagination,
      error: error,
    );
  }

  /// 📦 Serialize
  Map<String, dynamic> toJson() {
    return {
      "isSearching": isSearching,
      "query": query,
      "results": results,
      "pagination": pagination,
      "error": error,
    };
  }

  /// 📥 Deserialize
  factory ProfileSearchState.fromJson(Map<String, dynamic> json) {
    return ProfileSearchState(
      isSearching: json["isSearching"] ?? false,
      query: json["query"] ?? "",
      results: List<dynamic>.from(json["results"] ?? []),
      pagination: json["pagination"] != null
          ? Map<String, dynamic>.from(json["pagination"])
          : null,
      error: json["error"],
    );
  }
}
