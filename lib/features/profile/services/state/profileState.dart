// features/profile/store/profile_state.dart

import 'package:akalpit/features/profile/services/models/userProfileModel.dart';

class ProfileState {
  final bool isLoading;
  final bool isSuccess; // 👈 NEW
  final String? error;
  final UserProfileModel? profile;

  const ProfileState({
    this.isLoading = false,
    this.isSuccess = false,
    this.error,
    this.profile,
  });

  factory ProfileState.initial() => const ProfileState();

  ProfileState copyWith({
    bool? isLoading,
    bool? isSuccess,
    String? error,
    UserProfileModel? profile,
  }) {
    return ProfileState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? false, // 👈 reset unless explicitly set
      error: error,
      profile: profile ?? this.profile,
    );
  }

  /// ---------- Serialization ----------
  Map<String, dynamic> toJson() {
    return {
      'isLoading': isLoading,
      'isSuccess': isSuccess,
      'error': error,
      'profile': profile?.toJson(),
    };
  }

  factory ProfileState.fromJson(Map<String, dynamic> json) {
    return ProfileState(
      isLoading: json['isLoading'] ?? false,
      isSuccess: json['isSuccess'] ?? false,
      error: json['error'],
      profile: json['profile'] != null
          ? UserProfileModel.fromJson(json['profile'])
          : null,
    );
  }
}
