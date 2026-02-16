class FeedMetaModel {
  final int page;
  final int limit;
  final int total;
  final int totalPages;
  final bool hasNextPage;

  FeedMetaModel({
    required this.page,
    required this.limit,
    required this.total,
    required this.totalPages,
    required this.hasNextPage,
  });

  factory FeedMetaModel.fromJson(Map<String, dynamic> json) {
    return FeedMetaModel(
      page: json['page'],
      limit: json['limit'],
      total: json['total'],
      totalPages: json['totalPages'],
      hasNextPage: json['hasNextPage'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'page': page,
      'limit': limit,
      'total': total,
      'totalPages': totalPages,
      'hasNextPage': hasNextPage,
    };
  }
}
