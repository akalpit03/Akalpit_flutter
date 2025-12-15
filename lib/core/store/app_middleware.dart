import 'package:penverse/features/auth/services/auth_actions.dart';
import 'package:redux/redux.dart';
import '../../core/store/app_state.dart';
import '../../core/api/api_gateway.dart';

 

List<Middleware<AppState>> createAppMiddleware(ApiGateway apiGateway) {
  return [
    TypedMiddleware<AppState, RegisterAction>(_Register(apiGateway)),
    TypedMiddleware<AppState, LoginAction>(_Login(apiGateway)),

    
 
  ];
}

Middleware<AppState> _Register(ApiGateway apiGateway) {
  return (Store<AppState> store, action, NextDispatcher next) async {
    if (action is RegisterAction) {
      next(action);
      try {

        final response = await apiGateway.authService
            .register(email: action.email, password: action.password);
        store.dispatch(RegisterSuccessAction(response));
      } catch (e) {
        store.dispatch(RegisterFailureAction(e.toString()));
      }
    }
    // ✅ Handle fetching a single quiz by ID
    else {
      next(action);
    }
  };
}

Middleware<AppState> _Login(ApiGateway apiGateway) {
  return (Store<AppState> store, action, NextDispatcher next) async {
    if (action is LoginAction) {
      next(action); // sets isLoading = true in reducer
      try {
    

        final backendResponse = await apiGateway.authService.login(
          email: action.email,
          password: action.password,
        );
       
        // final response = {
        //   // "userId": backendResponse["data"]["user"]["_id"],
        //   "accessToken": backendResponse["data"]["accessToken"],
        //   "refreshToken": backendResponse["data"]["refreshToken"],
        // };

        store.dispatch(LoginSuccessAction(backendResponse));
      } catch (e) {
        store.dispatch(LoginFailureAction(e.toString()));
      }
    } else {
      next(action);
    }
  };
}
 