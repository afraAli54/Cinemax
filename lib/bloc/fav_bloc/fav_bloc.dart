import 'package:bloc/bloc.dart';
import 'package:cinemax/bloc/fav_bloc/fav_event.dart';
import 'package:cinemax/bloc/fav_bloc/fav_state.dart';
import 'package:cinemax/domain/usecase/fav_usecase.dart';
import 'package:cinemax/prefrence_repo.dart';

class FavMovieBloc extends Bloc<FavMovieEvent, FavMovieState> {
  final FavoriteMoviesUseCase favoriteMoviesUseCase;
  final PreferencesRepository repo;

  FavMovieBloc(this.repo, {required this.favoriteMoviesUseCase})
      : super(FavMovieInitialState()) {
    on<LoadFavoriteMoviesEvent>(_handleLoadFavoriteMovieEvent);
  }

  Future<void> _handleLoadFavoriteMovieEvent(
    LoadFavoriteMoviesEvent event,
    Emitter<FavMovieState> emit,
  ) async {
    emit(FavMovieLoadingState());

    try {
      final String sessionId = repo.getString('session_id') as String;
      final movie = await favoriteMoviesUseCase.getFavoriteMovies(sessionId);
      emit(FavMovieLoadedState(movie));
    } catch (error) {
      emit(FavMovieErrorState('Failed to fetch user data'));
    }
  }
}
