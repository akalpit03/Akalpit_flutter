import 'dart:io';
import 'package:akalpit/features/clubProfile/services/models/post_data.dart';
import 'package:akalpit/features/clubProfile/services/states/clubstate.dart';
class ClubState {
  final bool isLoading;
  final Club? club;
  final String? error;
  final String? selectedImagePath;

  final bool isPostCreating;
  final ClubPost? lastCreatedPost;

  final bool isPostsLoading;
  final List<ClubPost> posts;

  ClubState({
    required this.isLoading,
    this.club,
    this.error,
    this.selectedImagePath,
    this.isPostCreating = false,
    this.lastCreatedPost,
    this.isPostsLoading = false,
    this.posts = const [],
  });

  /// Initial state
  factory ClubState.initial() {
    return ClubState(
      isLoading: false,
      club: null,
      error: null,
      selectedImagePath: null,
      isPostCreating: false,
      lastCreatedPost: null,
      isPostsLoading: false,
      posts: const [],
    );
  }

  ClubState copyWith({
    bool? isLoading,
    Club? club,
    String? error,
    String? selectedImagePath,
    bool? isPostCreating,
    ClubPost? lastCreatedPost,
    bool? isPostsLoading,
    List<ClubPost>? posts,
  }) {
    return ClubState(
      isLoading: isLoading ?? this.isLoading,
      club: club ?? this.club,
      error: error,
      selectedImagePath: selectedImagePath ?? this.selectedImagePath,
      isPostCreating: isPostCreating ?? this.isPostCreating,
      lastCreatedPost: lastCreatedPost ?? this.lastCreatedPost,
      isPostsLoading: isPostsLoading ?? this.isPostsLoading,
      posts: posts ?? this.posts,
    );
  }

  Map<String, dynamic> toJson() => {
        'isLoading': isLoading,
        'club': club?.toJson(),
        'error': error,
        'selectedImagePath': selectedImagePath,
        'isPostCreating': isPostCreating,
        'lastCreatedPost': lastCreatedPost?.toJson(),
        'isPostsLoading': isPostsLoading,
        'posts': posts.map((e) => e.toJson()).toList(),
      };

  factory ClubState.fromJson(Map<String, dynamic> json) => ClubState(
        isLoading: json['isLoading'] ?? false,
        club: json['club'] != null ? Club.fromJson(json['club']) : null,
        error: json['error'],
        selectedImagePath: json['selectedImagePath'],
        isPostCreating: json['isPostCreating'] ?? false,
        lastCreatedPost: json['lastCreatedPost'] != null
            ? ClubPost.fromJson(json['lastCreatedPost'])
            : null,
        isPostsLoading: json['isPostsLoading'] ?? false,
        posts: json['posts'] != null
            ? (json['posts'] as List)
                .map((e) => ClubPost.fromJson(e))
                .toList()
            : [],
      );
}
