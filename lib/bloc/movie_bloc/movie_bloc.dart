import 'package:bloc/bloc.dart';
import 'package:cinemax/bloc/movie_bloc/movie_event.dart';
import 'package:cinemax/bloc/movie_bloc/movie_state.dart';
import 'package:cinemax/domain/model/movie_model.dart';
import 'package:cinemax/domain/usecase/movies_usecase.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  final MovieUseCase movieUseCase;

  MoviesBloc(this.movieUseCase) : super(MoviesInitial()) {
    on<MoviesEvent>((event, emit) async {
      if (event is FetchMoviesEvent) {
        emit(MoviesLoadingState());
        try {
          final List<Movie> movies =
              await movieUseCase.fetchMovies() as List<Movie>;
          emit(MoviesLoadedState(movies));
        } catch (e) {
          emit(MoviesErrorState(e.toString()));
        }
      }
    });
  }
}
