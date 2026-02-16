import 'package:akalpit/features/posts/clubfeed/services/models/feedstory.dart';
import 'package:akalpit/features/posts/clubfeed/services/models/metamodel.dart';

class FetchFeedAction {
  final String clubId;
  final int page;
  final int limit;

  FetchFeedAction({
    required this.clubId,
    this.page = 1,
    this.limit = 10,
  });
}


class FetchFeedSuccessAction {
  final List<FeedStoryModel> stories;
  final FeedMetaModel meta;

  FetchFeedSuccessAction({
    required this.stories,
    required this.meta,
  });
}
class FetchMoreFeedAction {
  final int page;
  final int limit;

  FetchMoreFeedAction({required this.page, this.limit = 10});
}
class FetchMoreFeedSuccessAction {
  final List<FeedStoryModel> stories;
  final FeedMetaModel meta;

  FetchMoreFeedSuccessAction({
    required this.stories,
    required this.meta,
  });
}
class FetchFeedFailureAction {
  final String error;

  FetchFeedFailureAction(this.error);
}
