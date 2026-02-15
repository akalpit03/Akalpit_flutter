import 'package:akalpit/core/store/app_state.dart';
import 'package:akalpit/features/profile/services/models/friends/friendmodel.dart';
import 'package:akalpit/features/profile/services/profileActions.dart';
 import 'package:redux/redux.dart';

class FriendsViewModel {
  final bool isLoading;
  final bool isSuccess;
  final String? error;
  final List<FriendModel> friends;

  final void Function()? refresh; // fetch friends again
  final void Function(String)? removeFriend; // optional

  FriendsViewModel({
    required this.isLoading,
    required this.isSuccess,
    required this.error,
    required this.friends,
    required this.refresh,
    this.removeFriend,
  });

  static FriendsViewModel fromStore(Store<AppState> store) {
    return FriendsViewModel(
      isLoading: store.state.profileState.isFriendsLoading,
      isSuccess: store.state.profileState.isFriendsSuccess,
      error: store.state.profileState.friendsError,
      friends: store.state.profileState.friends,
      refresh: () => store.dispatch(FetchMyFriendsAction()),
      // removeFriend: (id) => store.dispatch(RemoveFriendAction(id)), // if you implement
    );
  }
}
