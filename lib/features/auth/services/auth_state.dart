// ----------------------- AuthState -----------------------

class AuthState {
  final bool isLoading;
  final bool isLoggedIn;
  final bool isRegistered;
  final bool isOtpVerified; // ✅ NEW
  final String? userEmail;
  final String? userId;
  final String? accessToken;
  final String? refreshToken;
  final String? errorMessage;

  const AuthState({
    required this.isLoading,
    required this.isLoggedIn,
    required this.isRegistered,
    required this.isOtpVerified, // ✅ NEW
    this.userEmail,
    this.userId,
    this.accessToken,
    this.refreshToken,
    this.errorMessage,
  });

  AuthState copyWith({
    bool? isLoading,
    bool? isLoggedIn,
    bool? isRegistered,
    bool? isOtpVerified, // ✅ NEW
    String? userEmail,
    String? userId,
    String? accessToken,
    String? refreshToken,
    String? errorMessage,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      isRegistered: isRegistered ?? this.isRegistered,
      isOtpVerified: isOtpVerified ?? this.isOtpVerified,
      userEmail: userEmail ?? this.userEmail,
      userId: userId ?? this.userId,
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
      errorMessage: errorMessage,
    );
  }

  Map<String, dynamic> toJson() => {
        'isLoading': isLoading,
        'isLoggedIn': isLoggedIn,
        'isRegistered': isRegistered,
        'isOtpVerified': isOtpVerified, // ✅ NEW
        'userEmail': userEmail,
        'userId': userId,
        'accessToken': accessToken,
        'refreshToken': refreshToken,
        'errorMessage': errorMessage,
      };

  factory AuthState.initial() => const AuthState(
        isLoading: false,
        isLoggedIn: false,
        isRegistered: false,
        isOtpVerified: false, // ✅ DEFAULT
        userEmail: null,
        userId: null,
        accessToken: null,
        refreshToken: null,
        errorMessage: null,
      );

  static AuthState fromJson(Map<String, dynamic>? json) {
    if (json == null) return AuthState.initial();

    return AuthState(
      isLoading: json['isLoading'] ?? false,
      isLoggedIn: json['isLoggedIn'] ?? false,
      isRegistered: json['isRegistered'] ?? false,
      isOtpVerified: json['isOtpVerified'] ?? false,
      userEmail: json['userEmail'],
      userId: json['userId'],
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
      errorMessage: json['errorMessage'],
    );
  }
}
