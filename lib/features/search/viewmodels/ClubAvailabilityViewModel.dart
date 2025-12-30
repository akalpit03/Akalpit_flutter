// features/club/viewmodel/club_availability_viewmodel.dart

import 'package:akalpit/features/search/services/actions/searchActions.dart';
import 'package:akalpit/features/search/services/state/clubAvailability.dart';
import 'package:flutter/foundation.dart';
import 'package:redux/redux.dart';

import '../../../core/store/app_state.dart';
 

class ClubAvailabilityViewModel {
  final bool isChecking;
  final bool? available;
  final String? error;

  final void Function(String clubId) checkAvailability;
  final VoidCallback clear;

  ClubAvailabilityViewModel({
    required this.isChecking,
    required this.available,
    required this.error,
    required this.checkAvailability,
    required this.clear,
  });

  static ClubAvailabilityViewModel fromStore(Store<AppState> store) {
    final ClubAvailabilityState state =
        store.state.clubAvailabilityState;
 

    return ClubAvailabilityViewModel(
      isChecking: state.isChecking,
      available: state.available,
      error: state.error,

      /// 🔍 Trigger availability check
      checkAvailability: (String clubId) {
       print('Dispatching CheckClubAvailabilityAction for Club ID: $clubId');
        store.dispatch(
          CheckClubAvailabilityAction(clubId),
        );
      },

      /// 🧹 Reset availability state
      clear: () {
        store.dispatch(ClearClubAvailabilityAction());
      },
    );
  }
}
