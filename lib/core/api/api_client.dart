import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiClient {
  late Dio _dio;
  String? _token;

  // Singleton
  ApiClient._internal();
  static final ApiClient _instance = ApiClient._internal();
  factory ApiClient() => _instance;

  VoidCallback? onUnauthorized;

  Future<void> init({required String baseUrl, String? token, VoidCallback? onUnauthorized}) async {
    this.onUnauthorized = onUnauthorized;
    if (token != null) {
      _token = token;
      await _saveToken(token);
    } else {
      _token = await _loadToken();
    }

    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 60),
        receiveTimeout: const Duration(seconds: 60),
        headers: {
          'Content-Type': 'application/json',
          if (_token != null) 'Authorization': 'Bearer $_token',
        },
      ),
    );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // Inject token dynamically
          if (_token != null) {
            options.headers['Authorization'] = 'Bearer $_token';
          }

          print("➡️ REQUEST: ${options.method} ${options.uri}");
          if (options.data != null) print("📤 BODY: ${options.data}");
          if (options.queryParameters.isNotEmpty)
            print("🔍 QUERY: ${options.queryParameters}");
          print("🧾 HEADERS: ${options.headers}");

          return handler.next(options);
        },
        onResponse: (response, handler) {
          // 🔥 PRINT RESPONSE
          print(
              "⬅️ RESPONSE: [${response.statusCode}] ${response.requestOptions.uri}");
          print("📥 DATA: ${response.data}");

          return handler.next(response);
        },
        onError: (e, handler) {
          // 🔥 PRINT ERROR
          print("❌ ERROR: ${e.response?.statusCode} ${e.requestOptions.uri}");
          print("❗ MESSAGE: ${e.message}");
          print("📥 ERROR DATA: ${e.response?.data}");

          // 🚨 HANDLE UNAUTHORIZED / NOT FOUND (404/401)
          if (e.response?.statusCode == 404 || e.response?.statusCode == 401) {
            // Avoid loop if the logout request itself fails
            if (onUnauthorized != null && !e.requestOptions.path.contains('logout')) {
              print("🚨 404/401 detected on ${e.requestOptions.path}! Triggering global logout.");
              onUnauthorized!();
            }
          }

          return handler.next(e);
        },
      ),
    );
  }

  Future<void> updateToken(String token) async {
    _token = token;
    _dio.options.headers['Authorization'] = 'Bearer $_token';

    await _saveToken(token);
  }

  Future<void> clearToken() async {
    _token = null;
    _dio.options.headers.remove('Authorization');
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }

  /// Save token to SharedPreferences
  Future<void> _saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  /// Load token from SharedPreferences
  Future<String?> _loadToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  // POST request
  Future<Response> post(String path, {dynamic data}) async {
    return await _dio.post(path, data: data);
  }

  // GET request
  Future<Response> get(String path, {Map<String, dynamic>? queryParams}) async {
    return await _dio.get(path, queryParameters: queryParams);
  }

  Future<Response> put(String path, {dynamic data}) async {
    return await _dio.put(path, data: data);
  }

  Future<Response> patch(String path, {dynamic data}) async {
    return await _dio.patch(path, data: data);
  }

  Future<Response> delete(String path,
      {Map<String, dynamic>? queryParams}) async {
    return await _dio.delete(path, queryParameters: queryParams);
  }

  /// ================= MULTIPART POST =================
  /// Used for image/file uploads
  Future<Response> postFormData(
    String path, {
    required FormData formData,
  }) async {
    return await _dio.post(
      path,
      data: formData,
      options: Options(
        headers: {
          'Content-Type': 'multipart/form-data',
          if (_token != null) 'Authorization': 'Bearer $_token',
        },
      ),
    );
  }
}
