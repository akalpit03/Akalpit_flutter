import 'package:akalpit/features/clubProfile/services/states/clubs.dart';

class ClubScreenState {
  final Map<String, Club> byId;
  final List<String> ownedClubIds;
  final List<String> followingClubIds;
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
      ownedClubIds: [],
      followingClubIds: [],
      searchResultIds: [],
      myClubId: null,
      activeClubId: null,
      isLoading: false,
      error: null,
    );
  }

  /// 📥 FROM JSON
  factory ClubScreenState.fromJson(Map<String, dynamic> json) {
    return ClubScreenState(
      byId: (json['byId'] as Map<String, dynamic>?)?.map(
            (key, value) => MapEntry(key, Club.fromJson(value)),
          ) ??
          {},
      ownedClubIds: List<String>.from(json['ownedClubIds'] ?? []),
      followingClubIds: List<String>.from(json['followingClubIds'] ?? []),
      searchResultIds: List<String>.from(json['searchResultIds'] ?? []),

      /// ✅ restore myClubId
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
      'ownedClubIds': ownedClubIds,
      'followingClubIds': followingClubIds,
      'searchResultIds': searchResultIds,

      /// ✅ persist myClubId
      'myClubId': myClubId,

      'activeClubId': activeClubId,
      'error': error,
    };
  }

  ClubScreenState copyWith({
    Map<String, Club>? byId,
    List<String>? ownedClubIds,
    List<String>? followingClubIds,
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
      error: error,
    );
  }
}
