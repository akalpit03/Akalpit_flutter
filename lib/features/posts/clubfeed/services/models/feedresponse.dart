 
 

import 'package:akalpit/features/posts/clubfeed/services/models/feedstory.dart';
import 'package:akalpit/features/posts/clubfeed/services/models/metamodel.dart';

class FeedResponseModel {
  final List<FeedStoryModel> data;
  final FeedMetaModel meta;

  FeedResponseModel({
    required this.data,
    required this.meta,
  });

  factory FeedResponseModel.fromJson(Map<String, dynamic> json) {
    return FeedResponseModel(
      data: (json['data'] as List)
          .map((e) => FeedStoryModel.fromJson(e))
          .toList(),
      meta: FeedMetaModel.fromJson(json['meta']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data.map((e) => e.toJson()).toList(),
      'meta': meta.toJson(),
    };
  }
}
