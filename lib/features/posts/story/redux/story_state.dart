 
import 'package:akalpit/features/posts/story/redux/story_model.dart';

class StoryState {
  final bool isLoading;
  final StoryResponseModel? story;
  final String? error;
  final bool isEmpty;

  StoryState({
    required this.isLoading,
    required this.story,
    required this.error,
    required this.isEmpty,
  });

  factory StoryState.initial() {
    return StoryState(
      isLoading: false,
      story: null,
      error: null,
      isEmpty: false,
    );
  }

  StoryState copyWith({
    bool? isLoading,
    StoryResponseModel? story,
    String? error,
    bool? isEmpty,
  }) {
    return StoryState(
      isLoading: isLoading ?? this.isLoading,
      story: story ?? this.story,
      error: error,
      isEmpty: isEmpty ?? this.isEmpty,
    );
  }

  // ---------------------------
  // ✅ Convert State -> JSON
  // ---------------------------
  Map<String, dynamic> toJson() {
    return {
      'isLoading': isLoading,
      'story': story,       // null-safe
      'error': error,
      'isEmpty': isEmpty,
    };
  }

  // -----------------------------------------
  // ✅ Convert JSON -> State (hydration)
  // -----------------------------------------
  factory StoryState.fromJson(Map<String, dynamic> json) {
    return StoryState(
      isLoading: json['isLoading'] ?? false,
      story: json['story'] != null
          ? StoryResponseModel.fromJson(json['story'])
          : null,
      error: json['error'],
      isEmpty: json['isEmpty'] ?? false,
    );
  }
}
