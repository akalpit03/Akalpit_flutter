 
import 'package:akalpit/features/search/services/reducers/clubAvailabilty.dart';
import 'package:akalpit/features/search/services/searchReducers.dart';

import '../../features/auth/services/auth_reducers.dart';
 

import 'app_state.dart';

AppState appReducer(AppState state, dynamic action) {
  return AppState(
      authState: authReducer(state.authState, action),
      profileSearchState: profileSearchReducer(state.profileSearchState, action),
      clubAvailabilityState: clubAvailabilityReducer(state.clubAvailabilityState, action),
     
     );
}
