import 'package:akalpit/features/profile/services/models/userExperiencemodel.dart';

class FriendshipModel {
  final String status;
  final String? requester;
  final String? recipient;
  final bool isRequester;
  final bool isRecipient;
  final bool isFriend;

  FriendshipModel({
    required this.status,
    this.requester,
    this.recipient,
    required this.isRequester,
    required this.isRecipient,
    required this.isFriend,
  });

  factory FriendshipModel.fromJson(Map<String, dynamic> json) {
    return FriendshipModel(
      status: json['status']?.toString() ?? 'none',
      requester: json['requester']?.toString(),
      recipient: json['recipient']?.toString(),
      isRequester: json['isRequester'] ?? false,
      isRecipient: json['isRecipient'] ?? false,
      isFriend: json['isFriend'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "status": status,
      "requester": requester,
      "recipient": recipient,
      "isRequester": isRequester,
      "isRecipient": isRecipient,
      "isFriend": isFriend,
    };
  }
}

class UserProfileModel {
  final String id;
  final String displayName;
  final String? username;
  final String? location; // ✅ NEW
  final String? imageUrl;
  final String bio;

  final List<String> hobbies;
  final List<ExperienceModel> experiences;

  final int totalFriends;
  final int totalPosts;
  final int totalParticipations;

  final bool isSelf;
  final FriendshipModel? friendship;

  UserProfileModel({
    required this.id,
    required this.displayName,
    this.username,
    this.location, // ✅ NEW
    this.imageUrl,
    required this.bio,
    required this.hobbies,
    required this.experiences,
    required this.totalFriends,
    required this.totalPosts,
    required this.totalParticipations,
    required this.isSelf,
    this.friendship,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      id: json['userId']?.toString() ?? '',

      displayName: json['displayName']?.toString() ?? '',
      username: json['username']?.toString(),
      location: json['location']?.toString(), // ✅ NEW

      imageUrl: json['imageUrl']?.toString(),
      bio: json['bio']?.toString() ?? '',

      hobbies: (json['hobbies'] is List)
          ? List<String>.from(json['hobbies'])
          : [],

      experiences: (json['experiences'] is List)
          ? (json['experiences'] as List)
              .map((e) =>
                  ExperienceModel.fromJson(Map<String, dynamic>.from(e)))
              .toList()
          : [],

      totalFriends: json['totalFriends'] ?? 0,
      totalPosts: json['totalPosts'] ?? 0,
      totalParticipations: json['totalParticipations'] ?? 0,

      isSelf: json['isSelf'] ?? false,

      friendship: (json['friendship'] is Map)
          ? FriendshipModel.fromJson(
              Map<String, dynamic>.from(json['friendship']))
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "userId": id,
      "displayName": displayName,
      "username": username,
      "location": location, // ✅ NEW
      "imageUrl": imageUrl,
      "bio": bio,
      "hobbies": hobbies,
      "experiences": experiences.map((e) => e.toJson()).toList(),
      "totalFriends": totalFriends,
      "totalPosts": totalPosts,
      "totalParticipations": totalParticipations,
      "isSelf": isSelf,
      "friendship": friendship?.toJson(),
    };
  }
}
