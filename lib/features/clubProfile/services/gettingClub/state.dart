import 'dart:io';
import 'package:akalpit/features/clubProfile/services/states/clubs.dart';

class ClubState {
  final bool isLoading;
  final Club? club;
  final String? error;
  final String? selectedImagePath; // store path instead of File

  ClubState({
    required this.isLoading,
    this.club,
    this.error,
    this.selectedImagePath,
  });

  /// Initial state
  factory ClubState.initial() {
    return ClubState(
      isLoading: false,
      club: null,
      error: null,
      selectedImagePath: null,
    );
  }

  ClubState copyWith({
    bool? isLoading,
    Club? club,
    String? error,
    String? selectedImagePath,
  }) {
    return ClubState(
      isLoading: isLoading ?? this.isLoading,
      club: club ?? this.club,
      error: error,
      selectedImagePath: selectedImagePath ?? this.selectedImagePath,
    );
  }

  Map<String, dynamic> toJson() => {
        'isLoading': isLoading,
        'club': club?.toJson(),
        'error': error,
        'selectedImagePath': selectedImagePath,
      };

  factory ClubState.fromJson(Map<String, dynamic> json) => ClubState(
        isLoading: json['isLoading'] ?? false,
        club: json['club'] != null ? Club.fromJson(json['club']) : null,
        error: json['error'],
        selectedImagePath: json['selectedImagePath'],
      );
}
