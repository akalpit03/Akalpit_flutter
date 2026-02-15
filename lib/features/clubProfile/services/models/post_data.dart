class ClubPost {
  final String id;
  final String clubId;
  final String createdBy; // store only the userId as String
  final String title;
  final String content;
  final String type;
  final bool isEdited;
  final bool isDeleted;
  final DateTime createdAt;
  final DateTime updatedAt;

  const ClubPost({
    required this.id,
    required this.clubId,
    required this.createdBy,
    required this.title,
    required this.content,
    required this.type,
    required this.isEdited,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ClubPost.fromJson(Map<String, dynamic> json) {
    return ClubPost(
      id: json["_id"] ?? "",
      clubId: json["clubId"] ?? "",
      createdBy: json["createdBy"] is Map
          ? json["createdBy"]["_id"] ?? ""
          : json["createdBy"] ?? "",
      title: json["title"] ?? "",
      content: json["content"] ?? "",
      type: json["type"] ?? "",
      isEdited: json["isEdited"] ?? false,
      isDeleted: json["isDeleted"] ?? false,
      createdAt: DateTime.parse(json["createdAt"] ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(json["updatedAt"] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "clubId": clubId,
      "createdBy": {"_id": createdBy},
      "title": title,
      "content": content,
      "type": type,
      "isEdited": isEdited,
      "isDeleted": isDeleted,
      "createdAt": createdAt.toIso8601String(),
      "updatedAt": updatedAt.toIso8601String(),
    };
  }
}
