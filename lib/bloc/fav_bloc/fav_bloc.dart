import 'package:bloc/bloc.dart';
import 'package:cinemax/bloc/fav_bloc/fav_event.dart';
import 'package:cinemax/bloc/fav_bloc/fav_state.dart';
import 'package:cinemax/domain/model/movie_model.dart';
import 'package:cinemax/domain/usecase/fav_usecase.dart';
import 'package:cinemax/prefrence_repo.dart';

class FavMovieBloc extends Bloc<FavMovieEvent, FavMovieState> {
  final FavoriteMoviesUseCase favoriteMoviesUseCase;
  final PreferencesRepository repo;

  FavMovieBloc(this.repo, {required this.favoriteMoviesUseCase})
      : super(FavMovieInitialState());

  @override
  Stream<FavMovieState> mapEventToState(FavMovieEvent event) async* {
    if (event is LoadFavoriteMoviesEvent) {
      yield FavMovieLoadingState();

      try {
        final String sessionId = repo.getString('session_id') as String;
        final List<Movie> movies =
            await favoriteMoviesUseCase.getFavoriteMovies(sessionId);

        yield FavMovieLoadedState(movies);
      } catch (error) {
        yield FavMovieErrorState('Failed to fetch favorite movies');
      }
    }
  }
}
