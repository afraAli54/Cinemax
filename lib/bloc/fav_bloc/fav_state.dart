import 'package:cinemax/domain/model/movie_model.dart';

abstract class FavMovieState {}

class FavMovieInitialState extends FavMovieState {}

class FavMovieLoadingState extends FavMovieState {}

class FavMovieLoadedState extends FavMovieState {
  final List<Movie> movies;

  FavMovieLoadedState(this.movies);
}

class FavMovieErrorState extends FavMovieState {
  final String errorMessage;

  FavMovieErrorState(this.errorMessage);
}
