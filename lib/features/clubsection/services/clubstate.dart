import 'package:akalpit/features/clubProfile/services/states/clubs.dart';

class ClubState {
  final Map<String, Club> byId;

  final List<String> ownedClubIds;
  final List<String> followingClubIds;
  final List<String> searchResultIds;

  final String? activeClubId;

  final bool isLoading;
  final String? error;

  ClubState({
    required this.byId,
    required this.ownedClubIds,
    required this.followingClubIds,
    required this.searchResultIds,
    required this.activeClubId,
    required this.isLoading,
    required this.error,
  });

  factory ClubState.initial() {
    return ClubState(
      byId: {},
      ownedClubIds: [],
      followingClubIds: [],
      searchResultIds: [],
      activeClubId: null,
      isLoading: false,
      error: null,
    );
  }

  ClubState copyWith({
    Map<String, Club>? byId,
    List<String>? ownedClubIds,
    List<String>? followingClubIds,
    List<String>? searchResultIds,
    String? activeClubId,
    bool? isLoading,
    String? error,
  }) {
    return ClubState(
      byId: byId ?? this.byId,
      ownedClubIds: ownedClubIds ?? this.ownedClubIds,
      followingClubIds: followingClubIds ?? this.followingClubIds,
      searchResultIds: searchResultIds ?? this.searchResultIds,
      activeClubId: activeClubId ?? this.activeClubId,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}
