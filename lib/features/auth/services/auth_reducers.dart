import 'auth_state.dart';
import 'auth_actions.dart';

AuthState authReducer(AuthState state, dynamic action) {
  if (action is RegisterAction) {
    return state.copyWith(
      isLoading: true,
      errorMessage: null,
      isRegistered: false,
    );
  } else if (action is RegisterSuccessAction) {
    final user = action.response['user'] as Map<String, dynamic>;

    return state.copyWith(
      isLoading: false,
      isRegistered: true,
      userId: user['_id'] as String?,
      userEmail: user['email'] as String?,
      errorMessage: null,
    );
  } else if (action is RegisterFailureAction) {
    return state.copyWith(
      isLoading: false,
      isRegistered: false,
      errorMessage: action.error,
    );
  }

  if (action is VerifyOtpAction) {
    return state.copyWith(
      isLoading: true,
      errorMessage: null,
    );
  }

  if (action is VerifyOtpSuccessAction) {
    return state.copyWith(
      isLoading: false,
      isOtpVerified: true,
    );
  }

  if (action is VerifyOtpFailureAction) {
    return state.copyWith(
      isLoading: false,
      isOtpVerified: false,
      errorMessage: action.error,
    );
  }
if (action is ClearAuthErrorAction) {
    return state.copyWith(errorMessage: null);
  }
  // ------------------------------
  // VERIFY OTP
  // ------------------------------
  // else if (action is VerifyOtpAction) {
  //   return state.copyWith(isLoading: true, errorMessage: null);
  // }
  // else if (action is VerifyOtpSuccess) {
  //   return state.copyWith(
  //     isLoading: false,
  //     isLoggedIn: true,
  //     userId: action.userId,
  //     accessToken: action.accessToken,
  //     refreshToken: action.refreshToken,
  //   );
  // }
  // else if (action is VerifyOtpFailure) {
  //   return state.copyWith(isLoading: false, errorMessage: action.error);
  // }

  // ------------------------------
  // LOGIN
  // ------------------------------
  else if (action is LoginAction) {
    return state.copyWith(
      isLoading: true,
      errorMessage: null,
    );
  } else if (action is LoginSuccessAction) {
    final user = action.response['user'] as Map<String, dynamic>?;

    return state.copyWith(
      isLoading: false,
      isLoggedIn: true,
      userId: user?['_id'] as String?,
      accessToken: action.response['token'] as String?,
      refreshToken: action.response['refreshToken'] as String?,
    );
  } else if (action is LoginFailureAction) {
    return state.copyWith(
      isLoading: false,
      errorMessage: action.error,
    );
  }

  // ------------------------------
  // REFRESH TOKEN
  // // ------------------------------
  // else if (action is RefreshTokenAction) {
  //   return state.copyWith(isLoading: true);
  // }
  // else if (action is RefreshTokenSuccess) {
  //   return state.copyWith(
  //     isLoading: false,
  //     accessToken: action.accessToken,
  //     refreshToken: action.refreshToken,
  //   );
  // }
  // else if (action is RefreshTokenFailure) {
  //   return state.copyWith(isLoading: false, errorMessage: action.error);
  // }

  // ------------------------------
  // LOGOUT
  // ------------------------------
  // else if (action is LogoutAction) {
  //   return AuthState.initial();
  // }

  return state;
}
