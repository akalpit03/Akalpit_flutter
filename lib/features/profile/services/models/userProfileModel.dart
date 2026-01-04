class UserProfileModel {
  final String id;
  final String displayName;
  final String username;

  final String? imageUrl;
  final String about;
  final List<String> hobbies;
  final List<dynamic> experiences;
  final Map<String, dynamic> userTypeMeta;

  final bool isSelf;
  final Map<String, dynamic> stats;
  final Map<String, dynamic> friendship;

  UserProfileModel({
    required this.id,
    required this.displayName,
    required this.username,
    required this.about,
    required this.hobbies,
    required this.experiences,
    required this.userTypeMeta,
    required this.isSelf,
    required this.stats,
    required this.friendship,
    this.imageUrl,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      id: json['_id'],
      displayName: json['displayName'] ?? '',
      username: json['username'] ?? '',
      imageUrl: json['imageUrl'],
      about: json['about'] ?? '',
      hobbies: List<String>.from(json['hobbies'] ?? []),
      experiences: List<dynamic>.from(json['experiences'] ?? []),
      userTypeMeta: Map<String, dynamic>.from(json['userTypeMeta'] ?? {}),
      isSelf: json['isSelf'] ?? false,
      stats: Map<String, dynamic>.from(json['stats'] ?? {}),
      friendship: Map<String, dynamic>.from(json['friendship'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "displayName": displayName,
      "username": username,
      "imageUrl": imageUrl,
      "about": about,
      "hobbies": hobbies,
      "experiences": experiences,
      "userTypeMeta": userTypeMeta,
      "isSelf": isSelf,
      "stats": stats,
      "friendship": friendship,
    };
  }
}
