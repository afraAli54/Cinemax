import 'package:bloc/bloc.dart';
import 'package:cinemax/domain/usecase/profile_usecase.dart';
import 'package:cinemax/bloc/profile_bloc/profile_event.dart';
import 'package:cinemax/bloc/profile_bloc/profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileUseCase profileUseCase;

  ProfileBloc({required this.profileUseCase}) : super(ProfileInitialState()) {
    on<FetchUserDataEvent>(_handleFetchUserDataEvent);
  }

  Future<void> _handleFetchUserDataEvent(
    FetchUserDataEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileLoadingState());

    try {
      final user = await profileUseCase.fetchUserData();
      emit(ProfileLoadedState(user));
    } catch (error) {
      emit(ProfileErrorState('Failed to fetch user data'));
    }
  }
}
