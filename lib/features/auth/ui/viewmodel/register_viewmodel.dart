// features/auth/presentation/viewmodels/register_viewmodel.dart
 import 'package:redux/redux.dart';
 
import '../../services/auth_actions.dart';
import '../../services/auth_selectors.dart';
import '../../../../core/store/app_state.dart';

class RegisterViewModel {
  final bool isLoading;
    bool isRegistered = false;
  
  final String? errorMessage;
  final void Function(String, String,String) onRegister;
  void Function() clearError;

  RegisterViewModel({
    required this.isLoading,
    required this.isRegistered ,
    required this.errorMessage,
    required this.onRegister,
    required this.clearError,
  });

  factory RegisterViewModel.fromStore(Store<AppState> store) {
  return RegisterViewModel(
    isLoading: authLoadingSelector(store.state),
    isRegistered: isRegisteredSelector(store.state),
    errorMessage: authErrorSelector(store.state),
    onRegister: (email, password,role) {
    
      store.dispatch(RegisterAction(email, password,role));

    },
    clearError: () {
      store.dispatch(ClearAuthErrorAction());
    },
  );
}

}
