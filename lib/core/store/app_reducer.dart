 
import 'package:akalpit/features/clubProfile/services/gettingClub/reducers.dart';
import 'package:akalpit/features/clubProfile/services/membership/membershipReducers.dart';
import 'package:akalpit/features/profile/services/profileReducers.dart';
import 'package:akalpit/features/search/services/reducers/clubAvailabilty.dart';
import 'package:akalpit/features/search/services/reducers/searchClub.dart';
import 'package:akalpit/features/search/services/reducers/searchReducers.dart';

import '../../features/auth/services/auth_reducers.dart';
 

import 'app_state.dart';

AppState appReducer(AppState state, dynamic action) {
  return AppState(
      authState: authReducer(state.authState, action),
      profileSearchState: profileSearchReducer(state.profileSearchState, action),
      clubAvailabilityState: clubAvailabilityReducer(state.clubAvailabilityState, action),
      clubSearchState: clubSearchReducer(state.clubSearchState, action  ),
      profileState: profileReducer(state.profileState, action),
      clubState: clubReducer(state.clubState, action),
      clubMembershipState: clubMembershipReducer(state.clubMembershipState, action) 
     
     );
}
