// features/club_search/store/club_search_state.dart

class ClubSearchState {
  final bool isSearching;
  final String query;
  final List<dynamic> results; // Consider replacing dynamic with a Club model later
  final Map<String, dynamic>? pagination;
  final String? error;

  const ClubSearchState({
    this.isSearching = false,
    this.query = "",
    this.results = const [],
    this.pagination,
    this.error,
  });

  factory ClubSearchState.initial() {
    return const ClubSearchState();
  }

  /// 🔄 Copy method for Reducers
  ClubSearchState copyWith({
    bool? isSearching,
    String? query,
    List<dynamic>? results,
    Map<String, dynamic>? pagination,
    String? error,
  }) {
    return ClubSearchState(
      isSearching: isSearching ?? this.isSearching,
      query: query ?? this.query,
      results: results ?? this.results,
      pagination: pagination ?? this.pagination,
      error: error, // If error is passed as null, it clears the previous error
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
  factory ClubSearchState.fromJson(Map<String, dynamic> json) {
    return ClubSearchState(
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