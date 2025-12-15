import 'package:penverse/features/auth/services/auth_service.dart';

import 'api_client.dart';

class ApiGateway {
  final AuthService authService;

  ApiGateway._({
    required this.authService,
  });

  factory ApiGateway.create() {
    final client = ApiClient(); // internally create client
    return ApiGateway._(
      authService: AuthService(client),
    );
  }
}
