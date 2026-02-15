// features/profile/store/profile_state.dart

import 'package:akalpit/features/profile/services/models/friends/friendmodel.dart';
import 'package:akalpit/features/profile/services/models/incomoingRequests/request.dart';
import 'package:akalpit/features/profile/services/models/userProfileModel.dart';
 

class ProfileState {
  /// ---------------- Profile ----------------
  final bool isLoading;
  final bool isSuccess;
  final String? error;
  final UserProfileModel? profile;

  /// ---------------- Incoming Friend Requests ----------------
  final bool isRequestLoading;
  final bool isRequestSuccess;
  final String? requestError;
  final List<IncomingRequest> incomingRequests;

  /// ---------------- Friends List ----------------
  final bool isFriendsLoading;
  final bool isFriendsSuccess;
  final String? friendsError;
  final List<FriendModel> friends;

  const ProfileState({
    this.isLoading = false,
    this.isSuccess = false,
    this.error,
    this.profile,

    this.isRequestLoading = false,
    this.isRequestSuccess = false,
    this.requestError,
    this.incomingRequests = const [],

    this.isFriendsLoading = false,
    this.isFriendsSuccess = false,
    this.friendsError,
    this.friends = const [],
  });

  factory ProfileState.initial() => const ProfileState();

  /// ---------------- CopyWith ----------------
  ProfileState copyWith({
    bool? isLoading,
    bool? isSuccess,
    String? error,
    UserProfileModel? profile,

    bool? isRequestLoading,
    bool? isRequestSuccess,
    String? requestError,
    List<IncomingRequest>? incomingRequests,

    bool? isFriendsLoading,
    bool? isFriendsSuccess,
    String? friendsError,
    List<FriendModel>? friends,
  }) {
    return ProfileState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? false,
      error: error,
      profile: profile ?? this.profile,

      isRequestLoading: isRequestLoading ?? this.isRequestLoading,
      isRequestSuccess: isRequestSuccess ?? false,
      requestError: requestError,
      incomingRequests: incomingRequests ?? this.incomingRequests,

      isFriendsLoading: isFriendsLoading ?? this.isFriendsLoading,
      isFriendsSuccess: isFriendsSuccess ?? false,
      friendsError: friendsError,
      friends: friends ?? this.friends,
    );
  }

  /// ---------------- Serialization ----------------
  Map<String, dynamic> toJson() {
    return {
      /// Profile
      'isLoading': isLoading,
      'isSuccess': isSuccess,
      'error': error,
      'profile': profile?.toJson(),

      /// Incoming Requests
      'isRequestLoading': isRequestLoading,
      'isRequestSuccess': isRequestSuccess,
      'requestError': requestError,
      'incomingRequests':
          incomingRequests.map((e) => e.toJson()).toList(),

      /// Friends
      'isFriendsLoading': isFriendsLoading,
      'isFriendsSuccess': isFriendsSuccess,
      'friendsError': friendsError,
      'friends': friends.map((e) => e.toJson()).toList(),
    };
  }

  factory ProfileState.fromJson(Map<String, dynamic> json) {
    return ProfileState(
      /// Profile
      isLoading: json['isLoading'] ?? false,
      isSuccess: json['isSuccess'] ?? false,
      error: json['error'],
      profile: json['profile'] != null
          ? UserProfileModel.fromJson(json['profile'])
          : null,

      /// Incoming Requests
      isRequestLoading: json['isRequestLoading'] ?? false,
      isRequestSuccess: json['isRequestSuccess'] ?? false,
      requestError: json['requestError'],
      incomingRequests: (json['incomingRequests'] as List<dynamic>?)
              ?.map((e) => IncomingRequest.fromJson(e))
              .toList() ??
          [],

      /// Friends
      isFriendsLoading: json['isFriendsLoading'] ?? false,
      isFriendsSuccess: json['isFriendsSuccess'] ?? false,
      friendsError: json['friendsError'],
      friends: (json['friends'] as List<dynamic>?)
              ?.map((e) => FriendModel.fromJson(e))
              .toList() ??
          [],
    );
  }
}
