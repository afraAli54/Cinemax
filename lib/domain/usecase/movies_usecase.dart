import 'dart:convert';
import 'package:cinemax/domain/model/movie_model.dart';
import 'package:http/http.dart' as http;

class MovieUseCase {
  final String apiKey;

  MovieUseCase({required this.apiKey});

  Future<List<Movie>> fetchMovies(String movieAPI) async {
    final response = await http.get(Uri.parse(
        'https://api.themoviedb.org/3/movie/now_playing?api_key=$apiKey'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<Movie> movies = data['results'];
      return movies;
    } else {
      throw Exception('Failed to fetch movies');
    }
  }
}
