import 'package:akalpit/features/posts/clubfeed/services/models/feedstory.dart';
import 'package:akalpit/features/posts/clubfeed/services/models/metamodel.dart';

class FeedState {
  final bool isLoading;
  final List<FeedStoryModel> stories;
  final FeedMetaModel? meta;
  final String? error;
  final bool isFetchingMore;

  FeedState({
    required this.isLoading,
    required this.stories,
    required this.meta,
    required this.error,
    required this.isFetchingMore,
  });

  factory FeedState.initial() {
    return FeedState(
      isLoading: false,
      stories: [],
      meta: null,
      error: null,
      isFetchingMore: false,
    );
  }

  FeedState copyWith({
    bool? isLoading,
    List<FeedStoryModel>? stories,
    FeedMetaModel? meta,
    String? error,
    bool? isFetchingMore,
  }) {
    return FeedState(
      isLoading: isLoading ?? this.isLoading,
      stories: stories ?? this.stories,
      meta: meta ?? this.meta,
      error: error,
      isFetchingMore: isFetchingMore ?? this.isFetchingMore,
    );
  }

  // ---------------------------
  // ✅ Convert State -> JSON
  // ---------------------------
  Map<String, dynamic> toJson() {
    return {
      'isLoading': isLoading,
      'stories': stories.map((e) => e.toJson()).toList(),
      'meta': meta?.toJson(),
      'error': error,
      'isFetchingMore': isFetchingMore,
    };
  }

  // -----------------------------------------
  // ✅ Convert JSON -> State (Hydration)
  // -----------------------------------------
  factory FeedState.fromJson(Map<String, dynamic> json) {
    return FeedState(
      isLoading: json['isLoading'] ?? false,
      stories: json['stories'] != null
          ? (json['stories'] as List)
              .map((e) => FeedStoryModel.fromJson(e))
              .toList()
          : [],
      meta: json['meta'] != null
          ? FeedMetaModel.fromJson(json['meta'])
          : null,
      error: json['error'],
      isFetchingMore: json['isFetchingMore'] ?? false,
    );
  }
}
