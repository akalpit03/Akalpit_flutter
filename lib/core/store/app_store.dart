import 'package:akalpit/features/Events/activities/services/middleware.dart';
import 'package:akalpit/features/auth/services/auth_middleware.dart';
import 'package:akalpit/features/clubProfile/services/gettingClub/middleware.dart';
import 'package:akalpit/features/clubProfile/services/membership/joinClubMiddlewares.dart';
import 'package:akalpit/features/clubProfile/ui/mainPages/events/services/middleware.dart';
import 'package:akalpit/features/clubsection/services/middleware.dart';
import 'package:akalpit/features/misc/services/middleware.dart';
import 'package:akalpit/features/posts/story/redux/story_middleware.dart';
import 'package:akalpit/features/profile/services/profileMiddleware.dart';
import 'package:akalpit/features/search/services/middlewares/searchMiddleware.dart';

import 'package:redux/redux.dart';

import 'app_state.dart';
import 'app_reducer.dart';
import '../api/api_gateway.dart';

Future<Store<AppState>> createStore(ApiGateway apiGateway) async {
  final store = Store<AppState>(
    appReducer,
    initialState: AppState.initial(),
    middleware: [
      ...createAuthMiddleware(apiGateway),
      ...searchMiddleware(apiGateway),
      ...profileMiddleware(apiGateway),
      ...clubMiddleware(apiGateway),
      ...clubMembershipMiddleware(apiGateway),
      ...myClubMiddleware(apiGateway),
      ...createEventMiddleware(apiGateway),
      ...activityMiddleware(apiGateway),
      ...createStoryMiddleware(apiGateway.storyService),
      ...categoryMiddleware(apiGateway),
    ],
  );

  return store;
}
