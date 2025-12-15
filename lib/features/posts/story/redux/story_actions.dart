 

import 'package:akalpit/features/posts/story/redux/story_model.dart';

class FetchStoryByIdAction {
  final String topicId;

  FetchStoryByIdAction(this.topicId);
}

class FetchStoryByIdSuccessAction {
  final StoryResponseModel response;

  FetchStoryByIdSuccessAction(this.response);
}

class FetchStoryByIdFailureAction {
  final String error;

  FetchStoryByIdFailureAction(this.error);
}
