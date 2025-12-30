 

import 'package:akalpit/features/profile/services/models/userExperiencemodel.dart';

class UserProfileModel {
  final String userId;
  final String name;
  final String about;
  final List<String> hobbies;
  final String? imageUrl;
  final List<UserExperience> experiences;
  final Map<String, dynamic> userTypeMeta;

  UserProfileModel({
    required this.userId,
    required this.name,
    required this.about,
    required this.hobbies,
    this.imageUrl,
    required this.experiences,
    required this.userTypeMeta,
  });

  /// 📥 Creates an instance from JSON (Handles nested Experience list)
  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      userId: json['userId'] ?? "",
      name: json['name'] ?? "",
      about: json['about'] ?? "",
      hobbies: List<String>.from(json['hobbies'] ?? []),
      imageUrl: json['imageUrl'],
      experiences: (json['experiences'] as List? ?? [])
          .map((e) => UserExperience.fromJson(Map<String, dynamic>.from(e)))
          .toList(),
      userTypeMeta: Map<String, dynamic>.from(json['userTypeMeta'] ?? {}),
    );
  }

  /// 📦 Converts the entire profile including Experiences to JSON
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'name': name,
      'about': about,
      'hobbies': hobbies,
      'imageUrl': imageUrl,
      // Logic: Loop through each UserExperience object and call its specific toJson()
      'experiences': experiences.map((e) => e.toJson()).toList(),
      'userTypeMeta': userTypeMeta,
    };
  }
}