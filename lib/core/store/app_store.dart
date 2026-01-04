import 'package:akalpit/features/auth/services/auth_middleware.dart';
import 'package:akalpit/features/clubProfile/services/gettingClub/middleware.dart';
import 'package:akalpit/features/clubProfile/services/membership/joinClubMiddlewares.dart';
import 'package:akalpit/features/profile/services/profileMiddleware.dart';
import 'package:akalpit/features/search/services/middlewares/searchMiddleware.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:redux_persist/redux_persist.dart';
import 'package:redux_persist_flutter/redux_persist_flutter.dart';
import 'package:redux/redux.dart';

import 'app_state.dart';
import 'app_reducer.dart';
import '../api/api_gateway.dart';

Future<Store<AppState>> createStore(ApiGateway apiGateway) async {
  final persistor = Persistor<AppState>(
    storage: FlutterStorage(
      location: kIsWeb
          ? FlutterSaveLocation.sharedPreferences
          : FlutterSaveLocation.documentFile,
    ),
    serializer: JsonSerializer<AppState>(AppState.fromJson),
    debug: true,
  );

  final initialState = await persistor.load();

  final store = Store<AppState>(
    appReducer,
    initialState: initialState ?? AppState.initial(),
    middleware: [
      persistor.createMiddleware(),
      ...createAuthMiddleware(apiGateway),
      ...searchMiddleware(apiGateway),
      ...profileMiddleware(apiGateway),
      ...clubMiddleware(apiGateway),
      ...clubMembershipMiddleware(apiGateway),
    ],
  );

  return store;
}
