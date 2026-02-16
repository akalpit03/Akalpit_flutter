import 'package:akalpit/core/store/app_state.dart';
import 'package:akalpit/features/posts/clubfeed/services/models/feedstory.dart';
import 'package:akalpit/features/posts/clubfeed/services/models/metamodel.dart';
 
import 'package:redux/redux.dart';

class FeedViewModel {
  final bool isLoading;
  final bool isFetchingMore;
  final List<FeedStoryModel> stories;
  final FeedMetaModel? meta;
  final String? error;

  FeedViewModel({
    required this.isLoading,
    required this.isFetchingMore,
    required this.stories,
    required this.meta,
    required this.error,
  });

  bool get isEmpty => stories.isEmpty && !isLoading;

  bool get hasNextPage => meta?.hasNextPage ?? false;

  static FeedViewModel fromStore(Store<AppState> store) {
    final feedState = store.state.feedState;

    return FeedViewModel(
      isLoading: feedState.isLoading,
      isFetchingMore: feedState.isFetchingMore,
      stories: feedState.stories,
      meta: feedState.meta,
      error: feedState.error,
    );
  }
}
