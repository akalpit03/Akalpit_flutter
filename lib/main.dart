import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/api/api_client.dart';
import 'core/api/api_gateway.dart';
import 'core/theme/app_theme.dart';
import 'core/store/app_state.dart';
import 'core/store/app_store.dart';

import 'features/auth/ui/login_screen.dart';
import 'features/entrypoint/entrypoint_ui.dart';
import 'features/onboarding/presentation/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load token BEFORE building the app
  final prefs = await SharedPreferences.getInstance();
  final savedToken = prefs.getString('token');

  // Initialize ApiClient with stored token
  ApiClient().init(
    baseUrl: 'http://10.0.2.2:5000/api/v1',
    token: savedToken,
  );

  // Create API gateway & redux store
  final apiGateway = ApiGateway.create();
  final store = await createStore(apiGateway);

  runApp(MyApp(
    store: store,
    apiGateway: apiGateway,
    savedToken: savedToken,
  ));
}

class MyApp extends StatelessWidget {
  final Store<AppState> store;
  final ApiGateway apiGateway;
  final String? savedToken;

  const MyApp({
    super.key,
    required this.store,
    required this.apiGateway,
    required this.savedToken,
  });

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        title: 'akalpit',
        theme: AppTheme.lightTheme,
        initialRoute: '/',
        routes: {
          '/': (context) => AuthWrapper(savedToken: savedToken),
          '/login': (context) => const LoginScreen(),
        },
      ),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  final String? savedToken;

  const AuthWrapper({super.key, required this.savedToken});

  @override
  Widget build(BuildContext context) {
    // If token exists → user is logged in → go to home
    if (savedToken != null && savedToken!.isNotEmpty) {
      return const EntryPointUI();
    }

    // Otherwise → show splash first
    return const SplashScreen();
  }
}
