import 'dart:convert';

import 'package:cinemax/domain/model/movie_model.dart';
import 'package:cinemax/style_guide/app_colors.dart';
import 'package:cinemax/UI/widgets/movie_info_card.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  Future<List<Movie>> fetchMovies(String movieAPI) async {
    const apiKey = '45a1ee9c5a52396669dced36b29a6d61';
    final url = '$movieAPI?api_key=$apiKey';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body)['results'];
      final List<Movie> movies =
          responseData.map((json) => Movie.fromJson(json)).toList();
      return movies;
    } else {
      throw Exception('Failed to fetch movies');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryDark,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Search a title',
                labelStyle: TextStyle(color: AppColors.textDarkGrey),
                filled: true,
                fillColor: AppColors.primarySoft,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                prefixIcon: Icon(Icons.search, color: AppColors.textDarkGrey),
                prefixIconConstraints:
                    BoxConstraints(minWidth: 48, minHeight: 48),
                suffixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 1,
                      height: 24,
                      color: AppColors.textGrey,
                    ),
                    IconButton(
                      icon: Icon(Icons.more_horiz, color: AppColors.textWhite),
                      onPressed: () {},
                    ),
                  ],
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Movie>>(
              future:
                  fetchMovies('https://api.themoviedb.org/3/discover/movie'),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Failed to fetch movies'),
                  );
                } else {
                  final List<Movie> movies = snapshot.data!;
                  return ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: movies.length,
                    itemBuilder: (context, index) {
                      final movie = movies[index];
                      return MovieInfoCard(
                        movieName: movie.title,
                        posterUrl:
                            "https://image.tmdb.org/t/p/w500${movie.posterPath}",
                        genre: "action",
                        movieId: movie.id,
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
