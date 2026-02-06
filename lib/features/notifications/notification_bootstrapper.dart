import 'package:firebase_messaging/firebase_messaging.dart';
import '../../../../core/api/api_client.dart';
import '../../../../core/api/api_endpoints.dart';
import 'notification_service.dart';

class NotificationBootstrapper {
  final ApiClient client;

  NotificationBootstrapper(this.client);

  Future<void> initAfterLogin() async {
    // final fcmToken =
    //     await NotificationService.requestPermissionAndGetToken();

    

    // Send token to backend
    await client.patch(
      ApiEndpoints.updateFcmToken,
      data: {
        "fcmToken": "fcmToken",
      },
    );

    // Listen for future token refresh
    FirebaseMessaging.instance.onTokenRefresh.listen((newToken) async {
      await client.patch(
        ApiEndpoints.updateFcmToken,
        data: {
          "fcmToken": newToken,
        },
      );
    });
  }
}
