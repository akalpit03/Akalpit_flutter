import 'package:akalpit/features/posts/clubfeed/services/models/author.dart';
 

class FeedStoryModel {
  final String storyId;
  final String title;
  final String image;
  final DateTime createdAt;
  final String clubId;
  final FeedAuthorModel author;

  FeedStoryModel({
    required this.storyId,
    required this.title,
    required this.image,
    required this.createdAt,
    required this.clubId,
    required this.author,
  });

  factory FeedStoryModel.fromJson(Map<String, dynamic> json) {
    return FeedStoryModel(
      storyId: json['storyId'],
      title: json['title'],
      image: json['image'],
      createdAt: DateTime.parse(json['createdAt']),
      clubId: json['clubId'],
      author: FeedAuthorModel.fromJson(json['author']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'storyId': storyId,
      'title': title,
      'image': image,
      'createdAt': createdAt.toIso8601String(),
      'clubId': clubId,
      'author': author.toJson(),
    };
  }
}
