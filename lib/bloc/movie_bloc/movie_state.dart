import 'package:cinemax/domain/model/movie_model.dart';
import 'package:equatable/equatable.dart';

abstract class MoviesState extends Equatable {
  const MoviesState();

  @override
  List<Object?> get props => [];
}

class MoviesInitial extends MoviesState {}

class MoviesLoadingState extends MoviesState {}

class MoviesLoadedState extends MoviesState {
  final List<Movie> movies;

  MoviesLoadedState(this.movies);

  @override
  List<Object?> get props => [movies];
}

class MoviesErrorState extends MoviesState {
  final String error;

  MoviesErrorState(this.error);

  @override
  List<Object?> get props => [error];
}
