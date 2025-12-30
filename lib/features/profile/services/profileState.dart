// features/profile/store/profile_state.dart

import 'package:akalpit/features/profile/services/models/userProfileModel.dart';

class ProfileState {
  final bool isLoading;
  final String? error;
  final UserProfileModel? profile;

  const ProfileState({
    this.isLoading = false,
    this.error,
    this.profile,
  });

  factory ProfileState.initial() => const ProfileState();

  ProfileState copyWith({
    bool? isLoading,
    String? error,
    UserProfileModel? profile,
  }) {
    return ProfileState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      profile: profile ?? this.profile,
    );
  }
 
  Map<String, dynamic> toJson() {
    return {
      'isLoading': isLoading,
      'error': error,
      'profile': profile?.toJson(),  
    };
  }

 
  factory ProfileState.fromJson(Map<String, dynamic> json) {
    return ProfileState(
      isLoading: json['isLoading'] ?? false,
      error: json['error'],
      profile: json['profile'] != null 
          ? UserProfileModel.fromJson(json['profile']) 
          : null,
    );
  }
}