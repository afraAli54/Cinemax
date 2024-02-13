abstract class LoginEvent {}

class LoginButton extends LoginEvent {
  final String username;
  final String password;

  LoginButton({required this.username, required this.password});
}
