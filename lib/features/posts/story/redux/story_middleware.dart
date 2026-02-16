 
 
import 'package:akalpit/core/store/app_state.dart';
import 'package:akalpit/features/posts/clubfeed/services/actions.dart';
import 'package:akalpit/features/posts/story/redux/story_actions.dart';
import 'package:akalpit/features/posts/story/redux/story_services.dart';
import 'package:redux/redux.dart';

List<Middleware<AppState>> createStoryMiddleware(StoryService service) {
  return [
    TypedMiddleware<AppState, FetchStoryByIdAction>(
      _fetchStory(service),
    ),    TypedMiddleware<AppState, FetchFeedAction>(
      _fetchFeed(service),
    ),
    // TypedMiddleware<AppState, FetchMoreFeedAction>(
    //   _fetchMoreFeed(service),
    // ),
  ];
}

Middleware<AppState> _fetchStory(StoryService service) {
  return (Store<AppState> store, action, NextDispatcher next) async {
    if (action is FetchStoryByIdAction) {
      next(action);

      try {
        final response = await service.fetchStoryById(action.topicId);

        store.dispatch(FetchStoryByIdSuccessAction(response));
      } catch (e) {
        next(FetchStoryByIdFailureAction(e.toString()));
      }
    } else {
      next(action);
    }
  };
}
Middleware<AppState> _fetchFeed(StoryService service) {
  return (Store<AppState> store, action, NextDispatcher next) async {
    if (action is FetchFeedAction) {
      next(action);

      try {
        final response = await service.fetchClubStories(
          clubId: action.clubId,
          page: action.page,
          limit: action.limit,
        );

        store.dispatch(
          FetchFeedSuccessAction(
            stories: response.data,
            meta: response.meta,
          ),
        );
      } catch (e) {
        store.dispatch(
          FetchFeedFailureAction(e.toString()),
        );
      }
    } else {
      next(action);
    }
  };
}

// Middleware<AppState> _fetchMoreFeed(StoryService service) {
//   return (Store<AppState> store, action, NextDispatcher next) async {
//     if (action is FetchMoreFeedAction) {
//       next(action);

//       final currentState = store.state.feedState;

//       // 🛑 Prevent multiple calls
//       if (currentState.isFetchingMore) return;

//       // 🛑 Stop if no more pages
//       if (currentState.meta?.hasNextPage == false) return;

//       try {
//         final response = await service.fetchFeed(
//           page: action.page,
//           limit: action.limit,
//         );

//         store.dispatch(
//           FetchMoreFeedSuccessAction(
//             stories: response.data,
//             meta: response.meta,
//           ),
//         );
//       } catch (e) {
//         store.dispatch(
//           FetchFeedFailureAction(e.toString()),
//         );
//       }
//     } else {
//       next(action);
//     }
//   };
// }
