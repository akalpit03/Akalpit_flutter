// features/profile/services/models/friend_user.dart

class FriendUser {
  final String id;
  final String? imageUrl;
  final String displayName;
  final String username;

  const FriendUser({
    required this.id,
    this.imageUrl,
    required this.displayName,
    required this.username,
  });

  factory FriendUser.fromJson(Map<String, dynamic> json) {
    return FriendUser(
      id: json['_id'] ?? '',
      imageUrl: json['imageUrl'],
      displayName: json['displayName'] ?? '',
      username: json['username'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'imageUrl': imageUrl,
      'displayName': displayName,
      'username': username,
    };
  }
}
