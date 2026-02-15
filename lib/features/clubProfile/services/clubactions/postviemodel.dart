import 'package:akalpit/core/store/app_state.dart';
import 'package:akalpit/features/clubProfile/services/clubactions/actions.dart';
import 'package:akalpit/features/clubProfile/services/clubactions/state.dart';
import 'package:akalpit/features/clubProfile/services/models/post_data.dart';
import 'package:redux/redux.dart';

class PostsViewModel {
  final bool isPostsLoading;
  final List<ClubPost> posts;

  final void Function(String clubId, String date) fetchPostsByDate;

  PostsViewModel({
    required this.isPostsLoading,
    required this.posts,
    required this.fetchPostsByDate,
  });

  static PostsViewModel fromStore(Store<AppState> store) {
  final state = store.state.clubState;

  return PostsViewModel(
    isPostsLoading: state.isPostsLoading,
    posts: state.posts,
    fetchPostsByDate: (clubId, date) {
      store.dispatch(FetchClubPostsByDateAction(clubId: clubId, date: date));
    },
    // clearError: () {
    //   store.dispatch(ClearClubErrorAction());
    // },
    // add other callbacks similarly...
  );
}

}
