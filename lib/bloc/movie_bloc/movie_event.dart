import 'package:equatable/equatable.dart';

abstract class MoviesEvent extends Equatable {
  const MoviesEvent();

  @override
  List<Object?> get props => [];
}

class FetchMoviesEvent extends MoviesEvent {
  final String movieAPI;

  FetchMoviesEvent(this.movieAPI);

  @override
  List<Object?> get props => [movieAPI];
}
