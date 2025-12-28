class InitializeAuth {}

class RegisterAction {
  final String email;
  final String password;
  final String role;
  RegisterAction(this.email, this.password,this.role);
}

class RegisterSuccessAction {
  final Map<String, dynamic> response;
  RegisterSuccessAction(this.response);
}

class RegisterFailureAction {
  final String error;
  RegisterFailureAction(this.error);
}

class LoginAction {
  final String email;
  final String password;
  LoginAction(this.email, this.password);
}

class LoginSuccessAction {
  final Map<String, dynamic> response;
  LoginSuccessAction(this.response);
}

class LoginFailureAction {
  final String error;
  LoginFailureAction(this.error);
}

class Logout {}

class VerifyOtpAction {
  final String email;
  final String otp;

  VerifyOtpAction(this.email, this.otp);
}

class VerifyOtpSuccessAction {
  final Map<String, dynamic> response;

  VerifyOtpSuccessAction(this.response);
}

class VerifyOtpFailureAction {
  final String error;

  VerifyOtpFailureAction(this.error);
}

class ResendOtpAction {
  final String email;

  ResendOtpAction(this.email);
}

class ResendOtpSuccessAction {
  final Map<String, dynamic> response;

  ResendOtpSuccessAction(this.response);
}

class ResendOtpFailureAction {
  final String error;

  ResendOtpFailureAction(this.error);
}

class ClearAuthErrorAction {}
