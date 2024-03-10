import 'package:bloc/bloc.dart';
import 'package:cinemax/bloc/fav_bloc/fav_event.dart';
import 'package:cinemax/bloc/fav_bloc/fav_state.dart';
import 'package:cinemax/domain/usecase/fav_usecase.dart';
import 'package:cinemax/prefrence_repo.dart';

class FavMovieBloc extends Bloc<FavMovieEvent, FavMovieState> {
  final PreferencesRepository repo = PreferencesRepository();
  final FavoriteMoviesUseCase favoriteMoviesUseCase = FavoriteMoviesUseCase();

  FavMovieBloc() : super(FavMovieInitialState()) {
    on<LoadFavoriteMoviesEvent>(_handleLoadFavoriteMovieEvent);
  }

  void _handleLoadFavoriteMovieEvent(
    LoadFavoriteMoviesEvent event,
    Emitter<FavMovieState> emit,
  ) async {
    emit(FavMovieLoadingState());
    try {
      final String? sessionId = await repo.getString('session_id');
      if (sessionId != null) {
        final movies = await favoriteMoviesUseCase.getFavoriteMovies(sessionId);
        emit(FavMovieLoadedState(movies));
      } else {
        emit(FavMovieErrorState('Session ID not found'));
      }
    } catch (error) {
      emit(FavMovieErrorState('Failed to fetch favorite movies: $error'));
    }
  }
}
