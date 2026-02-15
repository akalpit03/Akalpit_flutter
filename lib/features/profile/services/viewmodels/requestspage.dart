import 'package:akalpit/core/store/app_state.dart';
import 'package:akalpit/features/profile/services/models/incomoingRequests/request.dart';
import 'package:akalpit/features/profile/services/profileActions.dart';
import 'package:redux/redux.dart';

class ViewModel {
  final bool isLoading;
  final String? error;
  final List<IncomingRequest> requests;
  final Function(String) accept;
  final Function(String) reject;

  ViewModel({
    required this.isLoading,
    required this.error,
    required this.requests,
    required this.accept,
    required this.reject,
  });

  static ViewModel fromStore(Store<AppState> store) {
    return ViewModel(
      isLoading: store.state.profileState.isRequestLoading,
      error: store.state.profileState.requestError,
      requests: store.state.profileState.incomingRequests,
      accept: (id) =>
          store.dispatch(AcceptFriendRequestAction(id)),
      reject: (id) =>
          store.dispatch(RejectFriendRequestAction(id)),
    );
  }
}
