import 'dart:convert';

import 'package:cinemax/constant.dart';
import 'package:cinemax/domain/model/movie_model.dart';
import 'package:http/http.dart' as http;

class Api {
  Future<List<Movie>> fetchMovies(String movieAPI) async {
    const apiKey = Constants.apiKey;
    final url = '$movieAPI?api_key=$apiKey';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body)['results'];
      final List<Movie> movies =
          responseData.map((json) => Movie.fromJson(json)).toList();
      return movies;
    } else {
      throw Exception('Failed to fetch popular movies');
    }
  }
}
