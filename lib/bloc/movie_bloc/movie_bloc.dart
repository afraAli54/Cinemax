import 'package:bloc/bloc.dart';
import 'package:cinemax/bloc/movie_bloc/movie_event.dart';
import 'package:cinemax/bloc/movie_bloc/movie_state.dart';
import 'package:cinemax/domain/usecase/movies_usecase.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  final MovieUseCase movieUseCase;

  MoviesBloc()
      : movieUseCase = MovieUseCase(),
        super(MoviesInitial()) {
    on<MoviesEvent>((event, emit) async {
      if (event is FetchMoviesEvent) {
        emit(MoviesLoadingState());
        try {
          final movies = await movieUseCase.fetchMovies();
          emit(MoviesLoadedState(movies));
        } catch (e) {
          emit(MoviesErrorState(e.toString()));
        }
      }
    });
  }
}
