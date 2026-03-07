import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/api/api_client.dart';
import '../../../../core/api/api_endpoints.dart';

class AuthService {
  final ApiClient client;

  AuthService(this.client);

 
  Future<Map<String, dynamic>> register({
  required String email,
  required String password,
  required String role,
}) async {
  final response = await client.post(
    ApiEndpoints.registerUser,
    data: {
      "email": email,
      "password": password,
      "role": role,
    },
  );

  final body = response.data;

  if (body is Map<String, dynamic>) {
    return body as Map<String, dynamic>;
  }

  throw Exception("Unexpected register response: $body");
}

 Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    final response = await client.post(
      ApiEndpoints.loginUser,
      data: {
        "email": email,
        "password": password,
      },
    );

    final body = response.data;

    if (body == null ||
        body["data"] == null ||
        body["data"]["accessToken"] == null ||
        body["data"]["refreshToken"] == null ||
        body["data"]["user"] == null) {
      throw Exception("Invalid login response format");
    }

    final token = body["data"]["accessToken"];
    final refreshToken = body["data"]["refreshToken"];
    final user = body["data"]["user"]; // full user object

    // Save tokens & user in SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token); // use real token here
    await prefs.setString('refreshToken', refreshToken);
    await prefs.setString('user', jsonEncode(user)); // ✅ store user as JSON

    // Update API client with access token
    ApiClient().updateToken(token);

    return body as Map<String, dynamic>;
  }

  
Future<Map<String, dynamic>> resendOtp({
    required String email,
  }) async {
    try {
      final response = await client.post(
        ApiEndpoints.resendOtp, // Ensure this exists in your endpoints
        data: {"email": email},
      );

      final body = response.data;

      if (body is Map<String, dynamic>) {
        return {
          "success": body["success"] ?? false,
          "message": body["message"] ?? "Success",
          "statusCode": body["statusCode"] ?? 200,
          "data": body["data"], // String: "OTP resent successfully"
        };
      }
      throw Exception("Unexpected resend OTP response format");
    } catch (e) {
      rethrow;
    }
  }


  
Future<Map<String, dynamic>> verifyOtp({
  required String email,
  required String otp,
}) async {
  final response = await client.post(
    ApiEndpoints.verifyOtp,
    data: {
      "email": email,
      "otp": otp,
    },
  );

  final body = response.data;

  if (body is Map<String, dynamic>) {
    return {
      "success": body["success"] ?? false,
      "message": body["message"] ?? "",
      "statusCode": body["statusCode"],
      "data": body["data"], // "OTP verified successfully"
    };
  }

  throw Exception("Unexpected verify OTP response: $body");
}

Future<Map<String, dynamic>> completeProfile({
  required String userId,
  required String username,
  required String displayName,
}) async {
  final response = await client.post(
    ApiEndpoints.completeProfile,
    data: {
      "userId": userId,
      "username": username,
      "displayName": displayName,
    },
  );

  final body = response.data;

  if (body is Map<String, dynamic> && body["success"] == true) {
    final token = body["data"]["accessToken"];
    final refreshToken = body["data"]["refreshToken"];

    // Save tokens in SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
    await prefs.setString('refreshToken', refreshToken);

    // Update API client with access token
    ApiClient().updateToken(token);

    // ✅ Update local user object to persist isProfileComplete
    final userStr = prefs.getString('user');
    Map<String, dynamic> user = {};
    if (userStr != null) {
      try {
        user = jsonDecode(userStr);
      } catch (_) {}
    }
    
    user['isProfileComplete'] = true;
    user['username'] = username;
    user['displayName'] = displayName;
    user['_id'] = userId; // Ensure ID is preserved
    
    await prefs.setString('user', jsonEncode(user));
    
    if (kDebugMode) {
      print("✅ STORED: Profile marked complete for $userId");
    }

    return {
      "success": true,
      "message": body["message"],
    };
  }

  throw Exception(body["message"] ?? "Failed to complete profile");
}

Future<void> logout() async {
  try {
    // 1. Notify server (optional, might fail if token expired)
    await client.post(ApiEndpoints.logoutUser);
  } catch (e) {
    if (kDebugMode) print("Logout server call failed (likely already expired): $e");
  } finally {
    // 2. Clear local memory (token in ApiClient)
    await client.clearToken();

    // 3. Clear persistent storage
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('refreshToken');
    await prefs.remove('user');
  }
}

Future<Map<String, dynamic>> changePassword({
  required String oldPassword,
  required String newPassword,
}) async {
  final response = await client.post(
    ApiEndpoints.changeCurrentPassword,
    data: {
      "oldPassword": oldPassword,
      "newPassword": newPassword,
    },
  );

  final body = response.data;
  if (body is Map<String, dynamic>) {
    return body;
  }
  throw Exception("Unexpected change-password response: $body");
}

  //   final body = response.data;

  //   if (body is Map<String, dynamic>) {
  //     return body;
  //     // Expected: { success, userId, message }
  //   }

  //   throw Exception("Unexpected reset-password otp response: $body");
  // }

 
  // Future<Map<String, dynamic>> resetPassword({
  //   required String userId,
  //   required String otp,
  //   required String newPassword,
  // }) async {
  //   final response = await client.post(
  //     ApiEndpoints.resetPassword,
  //     data: {
  //       "userId": userId,
  //       "otp": otp,
  //       "newPassword": newPassword,
  //     },
  //   );

  //   final body = response.data;

  //   if (body is Map<String, dynamic>) {
  //     return body;
  //     // Expected: { success, message }
  //   }

  //   throw Exception("Unexpected reset-password response: $body");
  // }
}
