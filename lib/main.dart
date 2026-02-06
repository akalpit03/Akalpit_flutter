import 'dart:convert'; // Added for jsonEncode/jsonDecode
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

import 'firebase_options.dart';
import 'features/auth/ui/screens/login_screen.dart';
import 'features/entrypoint/entrypoint_ui.dart';
import 'features/onboarding/presentation/screens/splash_screen.dart';

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

  await ApiClient().init(
    baseUrl: 'http://10.0.2.2:5000/api/v1',
    token: savedToken,
  );

  final apiGateway = ApiGateway.create();
  final store = await createStore(apiGateway);

  runApp(
    MyApp(
      store: store,
      apiGateway: apiGateway,
      savedToken: savedToken,
    ),
  );
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
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => AuthWrapper(savedToken: savedToken),
          '/login': (context) => const LoginScreen(),
          '/createAccount': (context) => const CreateAccountScreen(),
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
    if (savedToken != null && savedToken!.isNotEmpty) {
      return const EntryPointUI();
    }
    return const SplashScreen();
  }
}