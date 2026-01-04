import 'package:akalpit/features/clubProfile/services/states/models/clubMeta.dart';
import 'package:akalpit/features/clubProfile/services/states/models/owner.dart';

class Club {
  final String id;

  final ClubOwner? owner;

  final String clubId;
  final String clubName;
  final String? image;
  final String? about;

  final ClubMeta? council;
  final ClubMeta? institution;

  final String privacy; // public | private | invite_only
  final String status;  // active | suspended | deleted

  final int membersCount;
  final int postsCount;

  /// 🔐 USER CONTEXT FLAGS (VERY IMPORTANT)
  final bool isMember;
  final bool hasRequested;

  final DateTime createdAt;
  final DateTime updatedAt;

  const Club({
    required this.id,
    this.owner,
    required this.clubId,
    required this.clubName,
    this.image,
    this.about,
    this.council,
    this.institution,
    required this.privacy,
    required this.status,
    required this.membersCount,
    required this.postsCount,
    required this.isMember,
    required this.hasRequested,
    required this.createdAt,
    required this.updatedAt,
  });

  /// 🔁 FROM JSON
  factory Club.fromJson(Map<String, dynamic> json) {
    return Club(
      id: json["_id"].toString(),

      owner: json["owner"] != null
          ? ClubOwner.fromJson(json["owner"])
          : null,

      clubId: json["clubId"],
      clubName: json["clubName"],
      image: json["image"],
      about: json["about"],

      council: json["council"] != null
          ? ClubMeta.fromJson(json["council"])
          : null,

      institution: json["institution"] != null
          ? ClubMeta.fromJson(json["institution"])
          : null,

      privacy: json["privacy"] ?? "public",
      status: json["status"] ?? "active",

      membersCount: json["membersCount"] ?? 0,
      postsCount: json["postsCount"] ?? 0,

      isMember: json["isMember"] ?? false,
      hasRequested: json["hasRequested"] ?? false,

      createdAt: DateTime.parse(json["createdAt"]),
      updatedAt: DateTime.parse(json["updatedAt"]),
    );
  }

  /// 🔁 TO JSON
  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "owner": owner?.toJson(),
      "clubId": clubId,
      "clubName": clubName,
      "image": image,
      "about": about,
      "council": council?.toJson(),
      "institution": institution?.toJson(),
      "privacy": privacy,
      "status": status,
      "membersCount": membersCount,
      "postsCount": postsCount,
      "isMember": isMember,
      "hasRequested": hasRequested,
      "createdAt": createdAt.toIso8601String(),
      "updatedAt": updatedAt.toIso8601String(),
    };
  }

  /// 🧠 REDUX-FRIENDLY
  Club copyWith({
    String? image,
    String? about,
    int? membersCount,
    int? postsCount,
    String? status,
    String? privacy,
    bool? isMember,
    bool? hasRequested,
  }) {
    return Club(
      id: id,
      owner: owner,
      clubId: clubId,
      clubName: clubName,
      image: image ?? this.image,
      about: about ?? this.about,
      council: council,
      institution: institution,
      privacy: privacy ?? this.privacy,
      status: status ?? this.status,
      membersCount: membersCount ?? this.membersCount,
      postsCount: postsCount ?? this.postsCount,
      isMember: isMember ?? this.isMember,
      hasRequested: hasRequested ?? this.hasRequested,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
