import 'package:cinemax/bloc/login_bloc/login_event.dart';
import 'package:cinemax/bloc/login_bloc/login_state.dart';
import 'package:cinemax/domain/usecase/login_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase loginUseCase;

  LoginBloc({required this.loginUseCase}) : super(LoginInitial()) {
    on<LoginEvent>((event, emit) async {
      if (event is LoginButton) {
        emit(LoginLoading());
        try {
          final sessionId =
              await loginUseCase.login(event.username, event.password);
          emit(LoginSuccess(sessionId: sessionId, username: event.username));
        } catch (error) {
          emit(LoginFailure(error: error.toString()));
        }
      }
    });
  }
}
