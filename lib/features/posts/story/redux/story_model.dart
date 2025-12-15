class StoryResponseModel {
  final String title;
  final String topicId;
  final List<dynamic> blocks; 
  final String createdAt;
  final String updatedAt;

  StoryResponseModel({
    required this.title,
    required this.topicId,
    required this.blocks,
    required this.createdAt,
    required this.updatedAt,
  });

  factory StoryResponseModel.fromJson(Map<String, dynamic> json) {
    return StoryResponseModel(
      title: json['title'] ?? "",
      topicId: json['topicId'] ?? "",
      blocks: json['blocks'] ?? [],
      createdAt: json['createdAt'] ?? "",
      updatedAt: json['updatedAt'] ?? "",
    );
  }
}
