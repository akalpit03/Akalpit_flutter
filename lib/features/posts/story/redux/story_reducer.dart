import 'package:redux/redux.dart';
import 'story_actions.dart';
import 'story_state.dart';

final storyReducer = combineReducers<StoryState>([
  TypedReducer<StoryState, FetchStoryByIdAction>(_onLoad),
  TypedReducer<StoryState, FetchStoryByIdSuccessAction>(_onLoadSuccess),
  TypedReducer<StoryState, FetchStoryByIdFailureAction>(_onLoadFailure),
]);

StoryState _onLoad(
  StoryState state,
  FetchStoryByIdAction action,
) {
  return state.copyWith(
    isLoading: true,
    error: null,
  );
}

StoryState _onLoadSuccess(
  StoryState state,
  FetchStoryByIdSuccessAction action,
) {
  return state.copyWith(
    isLoading: false,
    story: action.response,
    error: null,
    isEmpty: action.response.blocks.isEmpty,
  );
}

StoryState _onLoadFailure(
  StoryState state,
  FetchStoryByIdFailureAction action,
) {
  return state.copyWith(
    isLoading: false,
    error:"errorr hai bhai kuch",
    story: null,
    isEmpty: true,
  );
}
