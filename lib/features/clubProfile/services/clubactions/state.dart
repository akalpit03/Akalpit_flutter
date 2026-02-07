import 'dart:io';
import 'package:akalpit/features/clubProfile/services/models/post_data.dart';
import 'package:akalpit/features/clubProfile/services/states/clubstate.dart';

class ClubState {
  final bool isLoading;
  final Club? club;
  final String? error;
  final String? selectedImagePath; // store path instead of File
final bool isPostCreating;
final ClubPost? lastCreatedPost;

  ClubState({
    required this.isLoading,
    this.club,
    this.error,
    this.selectedImagePath,
      this.isPostCreating = false,
      this.lastCreatedPost,
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
    );
  }

  ClubState copyWith({
    bool? isLoading,
    Club? club,
    String? error,
    String? selectedImagePath,
    bool? isPostCreating,
    ClubPost? lastCreatedPost,
  }) {
    return ClubState(
      isLoading: isLoading ?? this.isLoading,
      club: club ?? this.club,
      error: error,
      selectedImagePath: selectedImagePath ?? this.selectedImagePath,
      isPostCreating: this.isPostCreating, // keep unchanged
      lastCreatedPost: this.lastCreatedPost, // keep unchanged
    );
  }

  Map<String, dynamic> toJson() => {
        'isLoading': isLoading,
        'club': club?.toJson(),
        'error': error,
        'selectedImagePath': selectedImagePath,
        'isPostCreating': isPostCreating,
        'lastCreatedPost': lastCreatedPost?.toJson(),
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
      );
}
