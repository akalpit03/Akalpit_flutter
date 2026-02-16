 
import 'package:akalpit/features/Events/activities/services/reducer.dart';
import 'package:akalpit/features/clubProfile/services/clubactions/reducers.dart';
import 'package:akalpit/features/clubProfile/services/membership/membershipReducers.dart';
import 'package:akalpit/features/clubProfile/ui/mainPages/events/services/reducers.dart';
import 'package:akalpit/features/clubsection/services/reducers.dart';
import 'package:akalpit/features/misc/services/reducers.dart';
import 'package:akalpit/features/posts/clubfeed/services/reducers.dart';
import 'package:akalpit/features/posts/story/redux/story_reducer.dart';
import 'package:akalpit/features/profile/services/profileReducers.dart';
import 'package:akalpit/features/search/services/reducers/clubAvailabilty.dart';
import 'package:akalpit/features/search/services/reducers/searchClub.dart';
import 'package:akalpit/features/search/services/reducers/searchReducers.dart';
import 'package:akalpit/features/search/services/reducers/usernameAvail.dart';

import '../../features/auth/services/auth_reducers.dart';
 

import 'app_state.dart';

AppState appReducer(AppState state, dynamic action) {
  return AppState(
      authState: authReducer(state.authState, action),
      profileSearchState: profileSearchReducer(state.profileSearchState, action),
      clubAvailabilityState: clubAvailabilityReducer(state.clubAvailabilityState, action),
      usernameAvailabilityState: usernameAvailabilityReducer(state.usernameAvailabilityState, action),
      clubSearchState: clubSearchReducer(state.clubSearchState, action  ),
      profileState: profileReducer(state.profileState, action),
      clubState: clubReducer(state.clubState, action),
      clubMembershipState: clubMembershipReducer(state.clubMembershipState, action) ,
      clubScreenState: clubScreenReducer(state.clubScreenState, action),
      clubEventState: clubEventReducer(state.clubEventState,action),
      activityState: activityReducer(state.activityState, action),
      storyState: storyReducer(state.storyState, action),
      categoryState: categoryReducer(state.categoryState, action),
      feedState: feedReducer(state.feedState, action),
     
     );
}
