import 'package:akalpit/features/clubProfile/services/utils/roleenum.dart';

class Club {
  final String id;            // Mongo _id
  final String clubId;        // instagram-like id
  final String name;

  final String? image;
  final String? about;

  final List<String> categoryIds;

  final String ownerId;
  final List<String> adminIds;

  final String privacy;       // public / private / invite_only
  final String status;        // active / suspended / deleted

  final int membersCount;
  final int postsCount;

  final ClubRole myRole;

  final DateTime? createdAt;
  final DateTime? updatedAt;

  Club({
    required this.id,
    required this.clubId,
    required this.name,
    this.image,
    this.about,
    this.categoryIds = const [],
    required this.ownerId,
    this.adminIds = const [],
    required this.privacy,
    required this.status,
    required this.membersCount,
    required this.postsCount,
    required this.myRole,
    this.createdAt,
    this.updatedAt,
  });

  /// 🔁 From Backend JSON
  factory Club.fromJson(Map<String, dynamic> json, {String? myUserId}) {
    final ownerId = json['ownerId']?.toString() ?? '';

    final adminIds = (json['admins'] as List<dynamic>?)
        ?.map((e) => e.toString())
        .toList() ?? [];

    ClubRole role = ClubRole.none;

    if (myUserId != null) {
      if (myUserId == ownerId) {
        role = ClubRole.owner;
      } else if (adminIds.contains(myUserId)) {
        role = ClubRole.admin;
      }
    }

    return Club(
      id: json['_id'],
      clubId: json['clubId'],
      name: json['clubName'],
      image: json['image'],
      about: json['about'],
      categoryIds: (json['categories'] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList() ?? [],
      ownerId: ownerId,
      adminIds: adminIds,
      privacy: json['privacy'] ?? 'public',
      status: json['status'] ?? 'active',
      membersCount: json['membersCount'] ?? 0,
      postsCount: json['postsCount'] ?? 0,
      myRole: role,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'])
          : null,
    );
  }

  /// 🔁 To Backend (Create / Update)
  Map<String, dynamic> toJson() {
    return {
      'clubId': clubId,
      'clubName': name,
      'image': image,
      'about': about,
      'categories': categoryIds,
      'privacy': privacy,
    };
  }

  /// 🧩 Partial → Full merge support
  Club copyWith({
    String? name,
    String? image,
    String? about,
    List<String>? categoryIds,
    List<String>? adminIds,
    int? membersCount,
    int? postsCount,
    ClubRole? myRole,
  }) {
    return Club(
      id: id,
      clubId: clubId,
      name: name ?? this.name,
      image: image ?? this.image,
      about: about ?? this.about,
      categoryIds: categoryIds ?? this.categoryIds,
      ownerId: ownerId,
      adminIds: adminIds ?? this.adminIds,
      privacy: privacy,
      status: status,
      membersCount: membersCount ?? this.membersCount,
      postsCount: postsCount ?? this.postsCount,
      myRole: myRole ?? this.myRole,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
