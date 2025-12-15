 
 
import 'package:akalpit/core/store/app_state.dart';
import 'package:akalpit/features/posts/story/redux/story_actions.dart';
import 'package:akalpit/features/posts/story/redux/story_services.dart';
import 'package:redux/redux.dart';

List<Middleware<AppState>> createStoryMiddleware(StoryService service) {
  return [
    TypedMiddleware<AppState, FetchStoryByIdAction>(
      _fetchStory(service),
    ),
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
