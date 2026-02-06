import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationService {
  static Future<String?> requestPermissionAndGetToken() async {
    final messaging = FirebaseMessaging.instance;

    final settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized ||
        settings.authorizationStatus == AuthorizationStatus.provisional) {
      return await messaging.getToken();
    }

    return null;
  }

  static void listenForTokenRefresh(Function(String token) onTokenRefresh) {
    FirebaseMessaging.instance.onTokenRefresh.listen(onTokenRefresh);
  }
}
