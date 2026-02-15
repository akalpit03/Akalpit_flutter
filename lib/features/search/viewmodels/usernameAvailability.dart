 
import 'package:akalpit/features/search/services/actions/searchActions.dart';
import 'package:akalpit/features/search/services/state/usernameAvailability.dart';
import 'package:flutter/foundation.dart';
import 'package:redux/redux.dart';

import '../../../core/store/app_state.dart';

class UsernameAvailabilityViewModel {
  final bool isChecking;
  final bool? available;
  final String? error;

  final void Function(String username) checkAvailability;
  final VoidCallback clear;

  UsernameAvailabilityViewModel({
    required this.isChecking,
    required this.available,
    required this.error,
    required this.checkAvailability,
    required this.clear,
  });

  static UsernameAvailabilityViewModel fromStore(Store<AppState> store) {
    final UsernameAvailabilityState state =
        store.state.usernameAvailabilityState;
        
    return UsernameAvailabilityViewModel(
      isChecking: state.isChecking,
      available: state.available,
      error: state.error,

      /// 🔍 Trigger username availability check
      checkAvailability: (String username) {
        print('Dispatching CheckUsernameAvailabilityAction for Username: $username');
        store.dispatch(
          CheckUsernameAvailabilityAction(username),
        );
      },

      /// 🧹 Reset availability state
      clear: () {
        store.dispatch(ClearUsernameAvailabilityAction());
      },
    );
  }
}
