import 'dart:convert';
import 'package:cinemax/constant.dart';
import 'package:cinemax/domain/model/movie_model.dart';
import 'package:http/http.dart' as http;

class MovieUseCase {
  Future<List<Movie>> fetchMovies() async {
    final response = await http.get(Uri.parse(
        'https://api.themoviedb.org/3/discover/movie?api_key=${Constants.apiKey}'));
    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body)['results'];
      final List<Movie> movies =
          responseData.map((json) => Movie.fromJson(json)).toList();
      return movies;
    } else {
      throw Exception('Failed to fetch movies');
    }
  }
}
