import 'dart:convert';

import 'package:cinemax/domain/model/movie_model.dart';
import 'package:http/http.dart' as http;

class FavoriteMoviesUseCase {
  Future<List<Movie>> getFavoriteMovies(String sessionId) async {
    final url =
        Uri.https('api.themoviedb.org', '/3/account/20973161/favorite/movies', {
      'api_key': "45a1ee9c5a52396669dced36b29a6d61",
      'session_id': sessionId,
    });

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final List<dynamic> results = jsonData['results'];
      final List<Movie> favoriteMovies =
          results.map<Movie>((json) => Movie.fromJson(json)).toList();
      return favoriteMovies;
    } else {
      print('Error: ${response.statusCode}');
      return [];
    }
  }
}
