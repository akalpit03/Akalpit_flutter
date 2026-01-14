class ClubMembershipState {
  final bool isLoading;
  final String? error;

  final List<dynamic> members;
  final List<dynamic> admins; // <--- New field for Admins
  final List<dynamic> pendingRequests;
  final int memberCount;
  final String myRole;
  final List<dynamic> myClubs;

  ClubMembershipState({
    this.isLoading = false,
    this.error,
    this.members = const [],
    this.admins = const [], // <--- Initialize
    this.pendingRequests = const [],
    this.memberCount = 0,
    this.myRole = "guest",
    this.myClubs = const [],
  });

  /// =====================
  /// Copy With
  /// =====================
  ClubMembershipState copyWith({
    bool? isLoading,
    String? error,
    List<dynamic>? members,
    List<dynamic>? admins, // <--- Added to copyWith
    List<dynamic>? pendingRequests,
    int? memberCount,
    String? myRole,
    List<dynamic>? myClubs,
  }) {
    return ClubMembershipState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      members: members ?? this.members,
      admins: admins ?? this.admins, // <--- Correct assignment
      pendingRequests: pendingRequests ?? this.pendingRequests,
      memberCount: memberCount ?? this.memberCount,
      myRole: myRole ?? this.myRole,
      myClubs: myClubs ?? this.myClubs,
    );
  }

  /// =====================
  /// From JSON
  /// =====================
  factory ClubMembershipState.fromJson(Map<String, dynamic> json) {
    return ClubMembershipState(
      isLoading: json['isLoading'] ?? false,
      error: json['error'],
      members: json['members'] ?? [],
      admins: json['admins'] ?? [], // <--- Parse from JSON
      pendingRequests: json['pendingRequests'] ?? [],
      memberCount: json['memberCount'] ?? 0,
      myRole: json['myRole'] ?? "guest",
      myClubs: json['myClubs'] ?? [],
    );
  }

  /// =====================
  /// To JSON
  /// =====================
  Map<String, dynamic> toJson() {
    return {
      'isLoading': isLoading,
      'error': error,
      'members': members,
      'admins': admins, // <--- Add to JSON map
      'pendingRequests': pendingRequests,
      'memberCount': memberCount,
      'myRole': myRole,
      'myClubs': myClubs,
    };
  }

  /// Initial state
  factory ClubMembershipState.initial() {
    return ClubMembershipState(
      isLoading: false,
      error: null,
      members: [],
      admins: [], // <--- Reset to empty
      pendingRequests: [],
      memberCount: 0,
      myRole: "guest",
      myClubs: [],
    );
  }
}