// features/profile/services/models/friend_model.dart

import 'package:akalpit/features/profile/services/models/friends/friends.dart';
 

class FriendModel {
  final String id;
  final FriendUser requester;
  final FriendUser recipient;
  final String status;
  final String actionBy;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const FriendModel({
    required this.id,
    required this.requester,
    required this.recipient,
    required this.status,
    required this.actionBy,
    this.createdAt,
    this.updatedAt,
  });

  factory FriendModel.fromJson(Map<String, dynamic> json) {
    return FriendModel(
      id: json['_id'] ?? '',
      requester: FriendUser.fromJson(json['requester'] ?? {}),
      recipient: FriendUser.fromJson(json['recipient'] ?? {}),
      status: json['status'] ?? '',
      actionBy: json['actionBy'] ?? '',
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'])
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.tryParse(json['updatedAt'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'requester': requester.toJson(),
      'recipient': recipient.toJson(),
      'status': status,
      'actionBy': actionBy,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  /// 🔥 VERY IMPORTANT
  /// Returns the OTHER user based on current user id
  FriendUser getOtherUser(String currentUserId) {
    if (requester.id == currentUserId) {
      return recipient;
    }
    return requester;
  }
}
