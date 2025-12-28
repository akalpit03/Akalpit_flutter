import 'package:akalpit/core/api/api_gateway.dart';
import 'package:akalpit/core/store/app_state.dart';
import 'package:akalpit/features/auth/services/auth_actions.dart';
import 'package:redux/redux.dart';

List<Middleware<AppState>> createAuthMiddleware(ApiGateway apiGateway) {
  return [
    TypedMiddleware<AppState, RegisterAction>(
      register(apiGateway),
    ),
    TypedMiddleware<AppState, LoginAction>(login(apiGateway)),
    TypedMiddleware<AppState, VerifyOtpAction>(verifyOtp(apiGateway)),
    TypedMiddleware<AppState, ResendOtpAction>(resendOtp(apiGateway)),
  ];
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
        store.dispatch(RegisterFailureAction(e.toString()));
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
        store.dispatch(LoginFailureAction(e.toString()));
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
          VerifyOtpFailureAction(e.toString()),
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
          ResendOtpFailureAction(e.toString()),
        );
      }
    } else {
      next(action);
    }
  };
}
