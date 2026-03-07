import 'package:akalpit/core/api/api_gateway.dart';
import 'package:akalpit/core/store/app_state.dart';
import 'package:akalpit/features/auth/services/auth_actions.dart';
import 'package:dio/dio.dart';
import 'package:redux/redux.dart';

List<Middleware<AppState>> createAuthMiddleware(ApiGateway apiGateway) {
  return [
    TypedMiddleware<AppState, RegisterAction>(
      register(apiGateway),
    ),
    TypedMiddleware<AppState, LoginAction>(login(apiGateway)),
    TypedMiddleware<AppState, VerifyOtpAction>(verifyOtp(apiGateway)),
    TypedMiddleware<AppState, ResendOtpAction>(resendOtp(apiGateway)),
    TypedMiddleware<AppState, CompleteProfileAction>(completeProfile(apiGateway)),
    TypedMiddleware<AppState, LogoutAction>(logout(apiGateway)),
  ];
}

Middleware<AppState> completeProfile(ApiGateway apiGateway) {
  return (Store<AppState> store, action, NextDispatcher next) async {
    if (action is CompleteProfileAction) {
      next(action);
      try {
        final response = await apiGateway.authService.completeProfile(
          userId: action.userId,
          username: action.username,
          displayName: action.displayName,
        );
        store.dispatch(CompleteProfileSuccessAction(response));
      } catch (e) {
        store.dispatch(CompleteProfileFailureAction(_getErrorMessage(e)));
      }
    } else {
      next(action);
    }
  };
}

Middleware<AppState> logout(ApiGateway apiGateway) {
  return (Store<AppState> store, action, NextDispatcher next) async {
    if (action is LogoutAction) {
      next(action);
      try {
        await apiGateway.authService.logout();
        store.dispatch(LogoutSuccessAction());
      } catch (e) {
        store.dispatch(LogoutFailureAction(_getErrorMessage(e)));
      }
    } else {
      next(action);
    }
  };
}

Middleware<AppState> register(ApiGateway apiGateway) {
  return (Store<AppState> store, action, NextDispatcher next) async {
    if (action is RegisterAction) {
      next(action);
      try {
        final response = await apiGateway.authService
            .register(email: action.email, password: action.password,role: action.role);
        store.dispatch(RegisterSuccessAction(response));
      } catch (e) {
        store.dispatch(RegisterFailureAction(_getErrorMessage(e)));
      }
    }
 
    else {
      next(action);
    }
  };
}

Middleware<AppState> login(ApiGateway apiGateway) {
  return (Store<AppState> store, action, NextDispatcher next) async {
    if (action is LoginAction) {
      next(action); // sets isLoading = true in reducer
      try {
        final backendResponse = await apiGateway.authService.login(
          email: action.email,
          password: action.password,
        );

        store.dispatch(LoginSuccessAction(backendResponse));
      } catch (e) {
        store.dispatch(LoginFailureAction(_getErrorMessage(e)));
      }
    } else {
      next(action);
    }
  };
}

Middleware<AppState> verifyOtp(ApiGateway apiGateway) {
  return (Store<AppState> store, action, NextDispatcher next) async {
    if (action is VerifyOtpAction) {
      next(action);
      try {
        final backendResponse = await apiGateway.authService.verifyOtp(
          email: action.email,
          otp: action.otp,
        );

        store.dispatch(VerifyOtpSuccessAction(backendResponse));
      } catch (e) {
        store.dispatch(
          VerifyOtpFailureAction(_getErrorMessage(e)),
        );
      }
    } else {
      next(action);
    }
  };
}

Middleware<AppState> resendOtp(ApiGateway apiGateway) {
  return (Store<AppState> store, action, NextDispatcher next) async {
    if (action is ResendOtpAction) {
      next(action);
      try {
        final backendResponse = await apiGateway.authService.resendOtp(
          email: action.email,
        );

        store.dispatch(ResendOtpSuccessAction(backendResponse));
      } catch (e) {
        store.dispatch(
          ResendOtpFailureAction(_getErrorMessage(e)),
        );
      }
    } else {
      next(action);
    }
  };
}
String _getErrorMessage(dynamic e) {
  if (e is DioException) {
    if (e.response?.data is Map<String, dynamic>) {
      return e.response?.data['message'] ?? e.message ?? "An error occurred";
    }
    return e.message ?? "An error occurred";
  }
  return e.toString();
}
