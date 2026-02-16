import 'package:akalpit/features/posts/clubfeed/services/actions.dart';
import 'package:akalpit/features/posts/clubfeed/services/state.dart';
import 'package:redux/redux.dart';
 

final feedReducer = combineReducers<FeedState>([
  TypedReducer<FeedState, FetchFeedAction>(_onLoad),
  TypedReducer<FeedState, FetchFeedSuccessAction>(_onLoadSuccess),
  TypedReducer<FeedState, FetchMoreFeedAction>(_onLoadMore),
  TypedReducer<FeedState, FetchMoreFeedSuccessAction>(_onLoadMoreSuccess),
  TypedReducer<FeedState, FetchFeedFailureAction>(_onLoadFailure),
]);

// 🔹 First Load (Page 1)
FeedState _onLoad(
  FeedState state,
  FetchFeedAction action,
) {
  return state.copyWith(
    isLoading: true,
    error: null,
  );
}

// 🔹 First Load Success (Replace List)
FeedState _onLoadSuccess(
  FeedState state,
  FetchFeedSuccessAction action,
) {
  return state.copyWith(
    isLoading: false,
    stories: action.stories,
    meta: action.meta,
    error: null,
  );
}

// 🔹 Load More Trigger (Bottom Loader)
FeedState _onLoadMore(
  FeedState state,
  FetchMoreFeedAction action,
) {
  return state.copyWith(
    isFetchingMore: true,
    error: null,
  );
}

// 🔹 Load More Success (Append List)
FeedState _onLoadMoreSuccess(
  FeedState state,
  FetchMoreFeedSuccessAction action,
) {
  return state.copyWith(
    isFetchingMore: false,
    stories: [...state.stories, ...action.stories],
    meta: action.meta,
    error: null,
  );
}

// 🔹 Failure (Works for Both)
FeedState _onLoadFailure(
  FeedState state,
  FetchFeedFailureAction action,
) {
  return state.copyWith(
    isLoading: false,
    isFetchingMore: false,
    error: action.error,
  );
}
