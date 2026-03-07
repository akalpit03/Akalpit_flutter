import 'package:akalpit/features/auth/services/auth_actions.dart';
import 'package:akalpit/features/search/services/actions/searchActions.dart';
import 'package:akalpit/features/search/services/state/usernameAvailability.dart';
import 'package:flutter/foundation.dart';
import 'package:redux/redux.dart';

import '../../../core/store/app_state.dart';

class UsernameAvailabilityViewModel {
  final bool isChecking;
  final bool? available;
  final String? error;
  final String? userId; // from AuthState
  final bool isLoading; // from AuthState
  final bool isLoggedIn; // from AuthState
  final bool isProfileComplete; // from AuthState
  final String? authErrorMessage; // from AuthState

  final void Function(String username) checkAvailability;
  final VoidCallback clear;
  final void Function(String name, String username) onCompleteProfile;

  UsernameAvailabilityViewModel({
    required this.isChecking,
    required this.available,
    required this.error,
    required this.checkAvailability,
    required this.clear,
    required this.userId,
    required this.isLoading,
    required this.isLoggedIn,
    required this.isProfileComplete,
    required this.authErrorMessage,
    required this.onCompleteProfile,
  });

  static UsernameAvailabilityViewModel fromStore(Store<AppState> store) {
    final UsernameAvailabilityState state =
        store.state.usernameAvailabilityState;
    final authState = store.state.authState;
        
    return UsernameAvailabilityViewModel(
      isChecking: state.isChecking,
      available: state.available,
      error: state.error,
      userId: authState.userId,
      isLoading: authState.isLoading,
      isLoggedIn: authState.isLoggedIn,
      isProfileComplete: authState.isProfileComplete,
      authErrorMessage: authState.errorMessage,

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
      onCompleteProfile: (String name, String username) {
        if (authState.userId != null) {
          store.dispatch(CompleteProfileAction(authState.userId!, username, name));
        }
      }
    );
  }
}
