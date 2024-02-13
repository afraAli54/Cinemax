abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final String sessionId;
  final String username;

  LoginSuccess({required this.sessionId, required this.username});

  @override
  List<Object> get props => [sessionId, username];
}

class LoginFailure extends LoginState {
  final String error;

  LoginFailure({required this.error});
}
