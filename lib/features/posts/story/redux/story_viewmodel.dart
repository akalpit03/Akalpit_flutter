 
import 'package:akalpit/core/store/app_state.dart';
import 'package:akalpit/features/posts/story/redux/story_model.dart';
import 'package:redux/redux.dart';

class StoryViewModel {
  final bool isLoading;
  final bool isEmpty;
  final StoryResponseModel? story;
  final String? error;

  StoryViewModel({
    required this.isLoading,
    required this.story,
    required this.isEmpty,
    required this.error,
  });

  static StoryViewModel fromStore(Store<AppState> store) {
    return StoryViewModel(
      isLoading: store.state.storyState.isLoading,
      story: store.state.storyState.story,
      isEmpty: store.state.storyState.isEmpty,
      error: store.state.storyState.error,
    );
  }
}
