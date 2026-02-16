class FeedAuthorModel {
  final String userId;
  final String username;
  final String displayName;

  FeedAuthorModel({
    required this.userId,
    required this.username,
    required this.displayName,
  });

  factory FeedAuthorModel.fromJson(Map<String, dynamic> json) {
    return FeedAuthorModel(
      userId: json['userId'],
      username: json['username'],
      displayName: json['displayName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'username': username,
      'displayName': displayName,
    };
  }
}
