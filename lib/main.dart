import 'dart:convert';
import 'package:akalpit/features/entrypoint/router.dart';
import 'package:flutter/foundation.dart';
import 'package:akalpit/features/auth/ui/screens/create_account_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'core/api/api_client.dart';
import 'core/api/api_gateway.dart';
import 'core/theme/app_theme.dart';
import 'core/store/app_state.dart';
import 'core/store/app_store.dart';
import 'core/utils/navigation_service.dart';
import 'features/auth/services/auth_actions.dart';

import 'firebase_options.dart';
import 'features/auth/ui/screens/login_screen.dart';
import 'features/entrypoint/entrypoint_ui.dart';
import 'features/onboarding/presentation/screens/splash_screen.dart';
import 'features/auth/services/auth_state.dart';
import 'features/auth/ui/screens/username.dart';

/// 💾 Helper to save notification to local history
Future<void> _saveNotificationToHistory(RemoteMessage message) async {
  if (message.notification == null) return;

  final prefs = await SharedPreferences.getInstance();
  final String? encodedData = prefs.getString('notifications_history');
  List<dynamic> history = encodedData != null ? jsonDecode(encodedData) : [];

  // Create notification object matching your NotificationPage structure
  Map<String, String> newNotif = {
    "from": message.notification!.title ?? "Akalpit Team",
    "content": message.notification!.body ?? "",
    "time": "${DateTime.now().hour}:${DateTime.now().minute.toString().padLeft(2, '0')} ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
  };

  history.insert(0, newNotif); // Add to start of list
  await prefs.setString('notifications_history', jsonEncode(history));
}

/// 🔔 REQUIRED: Background FCM handler
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await _saveNotificationToHistory(message); // Save when app is in background
  debugPrint('🔕 Background FCM message: ${message.messageId}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ================= FIREBASE INIT =================
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // ================= FCM HANDLERS =================
  FirebaseMessaging.onBackgroundMessage(
    _firebaseMessagingBackgroundHandler,
  );

  // Foreground messages
  FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    debugPrint('🔔 Foreground message: ${message.notification?.title}');
    await _saveNotificationToHistory(message); // Save when app is open
  });

  // Notification tap
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    debugPrint('📲 Notification tapped: ${message.data}');
  });

  // ================= AUTH BOOTSTRAP =================
  final prefs = await SharedPreferences.getInstance();
  final savedToken = prefs.getString('token');
  final savedUserStr = prefs.getString('user');
  
  Map<String, dynamic>? savedUser;
  if (savedUserStr != null) {
    try {
      savedUser = jsonDecode(savedUserStr);
    } catch (e) {
      if (kDebugMode) print("Error decoding saved user: $e");
    }
  }

  if (kDebugMode) {
    print("🚀 BOOTSTRAP: isLoggedIn=${savedToken != null}, isProfileComplete=${savedUser?['isProfileComplete']}");
  }

  // 1️⃣ Initialize ApiClient (callback will be connected to store later)
  final apiClient = ApiClient();
  await apiClient.init(
    baseUrl: 'http://localhost:8000/api/v1',
    token: savedToken,
  );

  final apiGateway = ApiGateway.create();
  
  // Initialize state from saved data
  final initialState = AppState.initial().copyWith(
    authState: AuthState.initial().copyWith(
      isLoggedIn: savedToken != null,
      accessToken: savedToken,
      userId: savedUser?['_id'] as String?,
      userEmail: savedUser?['email'] as String?,
      isProfileComplete: (savedUser?['isProfileComplete'] == true),
    ),
  );

  final store = await createStore(apiGateway, initialState: initialState);

  // 2️⃣ Connect ApiClient logout to Redux
  apiClient.onUnauthorized = () {
    if (store.state.authState.isLoggedIn) {
      store.dispatch(LogoutAction());
    }
  };

  runApp(
    MyApp(
      store: store,
      apiGateway: apiGateway,
    ),
  );
}

class MyApp extends StatelessWidget {
  final Store<AppState> store;
  final ApiGateway apiGateway;

  const MyApp({
    super.key,
    required this.store,
    required this.apiGateway,
  });

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        title: 'akalpit',
        theme: AppTheme.lightTheme,
        debugShowCheckedModeBanner: false,
        navigatorKey: NavigationService.navigatorKey,
        initialRoute: '/',
        routes: {
          '/': (context) => const AuthWrapper(),
          '/login': (context) => const LoginScreen(),
          '/home': (context) => const RoleBasedRouter(),
          '/completeProfile': (context) => const EnterNameUsernameScreen(),
          '/createAccount': (context) => const CreateAccountScreen(),
        },
        builder: (context, child) {
          return StoreConnector<AppState, _AuthGuardViewModel>(
            converter: (store) => _AuthGuardViewModel(
              isLoggedIn: store.state.authState.isLoggedIn,
              isProfileComplete: store.state.authState.isProfileComplete,
            ),
            distinct: true,
            onWillChange: (prev, curr) {
              // 🚀 GLOBAL REDIRECT LOGIC
              if (curr.isLoggedIn) {
                // If they were on login and just logged in, or if state refreshed
                // We don't want to FORCE redirect EVERY state change, only if they are on a protected route.
                // But LoginScreen already handles its own redirect.
              } else if (prev?.isLoggedIn == true && !curr.isLoggedIn) {
                // Just logged out
                NavigationService.pushNamedAndRemoveUntil('/login');
              }
            },
            builder: (context, vm) => child!,
          );
        },
      ),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _AuthWrapperViewModel>(
      distinct: true,
      converter: (store) => _AuthWrapperViewModel(
        isLoggedIn: store.state.authState.isLoggedIn,
        isProfileComplete: store.state.authState.isProfileComplete,
      ),
      builder: (context, vm) {
        if (vm.isLoggedIn) {
          if (vm.isProfileComplete) {
            return const EntryPointUI();
          } else {
            return const EnterNameUsernameScreen();
          }
        }
        return const SplashScreen();
      },
    );
  }
}

class _AuthWrapperViewModel {
  final bool isLoggedIn;
  final bool isProfileComplete;
  _AuthWrapperViewModel({
    required this.isLoggedIn,
    required this.isProfileComplete,
  });
}

class _AuthGuardViewModel {
  final bool isLoggedIn;
  final bool isProfileComplete;
  _AuthGuardViewModel({
    required this.isLoggedIn,
    required this.isProfileComplete,
  });
}