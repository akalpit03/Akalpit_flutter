import 'package:akalpit/features/clubsection/services/models/myclubs.dart';

class ClubScreenState {
  final Map<String, MyClub> byId;
  final Map<String, MyClub> ownedClubIds;
  final Map<String, MyClub> followingClubIds;
  final List<String> searchResultIds;

  final String? myClubId;
  final String? activeClubId;
  final bool isLoading;
  final String? error;

  ClubScreenState({
    required this.byId,
    required this.ownedClubIds,
    required this.followingClubIds,
    required this.searchResultIds,
    required this.myClubId,
    required this.activeClubId,
    required this.isLoading,
    required this.error,
  });

  factory ClubScreenState.initial() {
    return ClubScreenState(
      byId: {},
      ownedClubIds: {},
      followingClubIds: {},
      searchResultIds: [],
      myClubId: null,
      activeClubId: null,
      isLoading: false,
      error: null,
    );
  }

  /// 📥 FROM JSON
  factory ClubScreenState.fromJson(Map<String, dynamic> json) {
    Map<String, MyClub> parseMyClubMap(dynamic data) {
      if (data == null) return {};
      final map = data as Map<String, dynamic>;
      return map.map(
        (key, value) => MapEntry(key, MyClub.fromJson(value)),
      );
    }

    return ClubScreenState(
      byId: parseMyClubMap(json['byId']),
      ownedClubIds: parseMyClubMap(json['ownedClubIds']),
      followingClubIds: parseMyClubMap(json['followingClubIds']),
      searchResultIds: List<String>.from(json['searchResultIds'] ?? []),
      myClubId: json['myClubId'] as String?,
      activeClubId: json['activeClubId'] as String?,
      isLoading: false,
      error: json['error'] as String?,
    );
  }

  /// 📤 TO JSON
  Map<String, dynamic> toJson() {
    return {
      'byId': byId.map((key, value) => MapEntry(key, value.toJson())),
      'ownedClubIds':
          ownedClubIds.map((key, value) => MapEntry(key, value.toJson())),
      'followingClubIds':
          followingClubIds.map((key, value) => MapEntry(key, value.toJson())),
      'searchResultIds': searchResultIds,
      'myClubId': myClubId,
      'activeClubId': activeClubId,
      'error': error,
    };
  }

  ClubScreenState copyWith({
    Map<String, MyClub>? byId,
    Map<String, MyClub>? ownedClubIds,
    Map<String, MyClub>? followingClubIds,
    List<String>? searchResultIds,
    String? myClubId,
    String? activeClubId,
    bool? isLoading,
    String? error,
  }) {
    return ClubScreenState(
      byId: byId ?? this.byId,
      ownedClubIds: ownedClubIds ?? this.ownedClubIds,
      followingClubIds: followingClubIds ?? this.followingClubIds,
      searchResultIds: searchResultIds ?? this.searchResultIds,
      myClubId: myClubId ?? this.myClubId,
      activeClubId: activeClubId ?? this.activeClubId,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}
