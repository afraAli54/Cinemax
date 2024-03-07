import 'package:bloc/bloc.dart';
import 'package:cinemax/bloc/movie_bloc/movie_event.dart';
import 'package:cinemax/bloc/movie_bloc/movie_state.dart';
import 'package:cinemax/domain/model/movie_model.dart';
import 'package:cinemax/domain/usecase/movies_usecase.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  final MovieUseCase movieUseCase;

  MoviesBloc(this.movieUseCase) : super(MoviesInitial()) {
    on<FetchMoviesEvent>(_mapFetchMoviesEventToState);
  }

  Stream<MoviesState> _mapFetchMoviesEventToState(
      FetchMoviesEvent event, Emitter<MoviesState> emit) async* {
    yield MoviesLoadingState();
    try {
      final List<Movie> movies = await movieUseCase.fetchMovies(event.movieAPI);
      yield MoviesLoadedState(movies);
    } catch (e) {
      yield MoviesErrorState(e.toString());
    }
  }
}
