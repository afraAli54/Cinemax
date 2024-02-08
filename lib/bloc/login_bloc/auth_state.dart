abstract class AuthState {}

class AuthInitial extends AuthState {}

class LoginLoading extends AuthState {}

class LoginSuccess extends AuthState {
  String sessionId;
  LoginSuccess({required this.sessionId});
}

class LoginFailure extends AuthState {
  String errorMessege;
  LoginFailure({required this.errorMessege});
}

class SignUpLoading extends AuthState {}

class SignUpSuccess extends AuthState {}

class SignUpFailure extends AuthState {
  String errMessege;
  SignUpFailure(this.errMessege);
}
