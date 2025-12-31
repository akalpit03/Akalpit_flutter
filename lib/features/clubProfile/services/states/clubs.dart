import 'package:akalpit/features/clubProfile/services/states/models/owner.dart';

class Club {
  final String id; // Mongo _id
 final ClubOwner? owner;

  final String clubId;
  final String clubName;
  final String? image;
  final String? about;

  final List<String> categories;
  final String? councilId;
  final String? institutionId;

  final List<String> admins;
  final List<String> members;

  final String privacy; // public | private | invite_only
  final String status; // active | suspended | deleted

  final int membersCount;
  final int postsCount;

  final DateTime createdAt;
  final DateTime updatedAt;

  const Club({
    required this.id,
     this.owner,
    required this.clubId,
    required this.clubName,
    this.image,
    this.about,
    required this.categories,
    this.councilId,
    this.institutionId,
    required this.admins,
    required this.members,
    required this.privacy,
    required this.status,
    required this.membersCount,
    required this.postsCount,
    required this.createdAt,
    required this.updatedAt,
  });

  /// 🔁 FROM JSON (Backend → App State)
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

    categories:
        (json["categories"] as List?)?.map((e) => e.toString()).toList() ?? [],

    councilId: json["councilId"]?.toString(),
    institutionId: json["institutionId"]?.toString(),

    admins:
        (json["admins"] as List?)?.map((e) => e.toString()).toList() ?? [],

    members:
        (json["members"] as List?)?.map((e) => e.toString()).toList() ?? [],

    privacy: json["privacy"] ?? "public",
    status: json["status"] ?? "active",
    membersCount: json["membersCount"] ?? 0,
    postsCount: json["postsCount"] ?? 0,

    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
  );
}

  /// 🔁 TO JSON (App State → API)
Map<String, dynamic> toJson() {
  return {
    "_id": id,
    "owner": owner?.toJson(),
    "clubId": clubId,
    "clubName": clubName,
    "image": image,
    "about": about,
    "categories": categories,
    "councilId": councilId,
    "institutionId": institutionId,
    "admins": admins,
    "members": members,
    "privacy": privacy,
    "status": status,
    "membersCount": membersCount,
    "postsCount": postsCount,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
  };
}


  /// 🧠 Redux-friendly copyWith
  Club copyWith({
    String? image,
    String? about,
    List<String>? admins,
    List<String>? members,
    int? membersCount,
    int? postsCount,
    String? status,
    String? privacy,
  }) {
    return Club(
      id: id,
      owner: owner,
      clubId: clubId,
      clubName: clubName,
      image: image ?? this.image,
      about: about ?? this.about,
      categories: categories,
      councilId: councilId,
      institutionId: institutionId,
      admins: admins ?? this.admins,
      members: members ?? this.members,
      privacy: privacy ?? this.privacy,
      status: status ?? this.status,
      membersCount: membersCount ?? this.membersCount,
      postsCount: postsCount ?? this.postsCount,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
