import 'dart:convert';

import 'package:cinemax/UI/widgets/movie_info_card.dart';
import 'package:cinemax/domain/model/movie_model.dart';
import 'package:cinemax/style_guide/app_colors.dart';
import 'package:cinemax/style_guide/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class FavScreen extends StatelessWidget {
  const FavScreen({super.key});

  @override
  Future<String?> getSessionId() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString('session_id');
  }

  Future<List<Movie>> getFavoriteMovies() async {
    final sessionId = await getSessionId();

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

  Widget build(BuildContext context) {
    AppTypography typography = AppTypography();
    return Scaffold(
      backgroundColor: AppColors.primaryDark,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          "Favorites",
          style: typography.h4SemiBold.copyWith(color: Colors.white),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            margin: const EdgeInsets.all(5),
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: AppColors.primarySoft,
              borderRadius: BorderRadius.circular(20),
            ),
            child: SvgPicture.asset(
              "assets/images/arrow-back.svg",
              fit: BoxFit.scaleDown,
            ),
          ),
        ),
      ),
      body: FutureBuilder<List<Movie>>(
        future: getFavoriteMovies(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Failed to fetch favorite movies'),
            );
          } else {
            final List<Movie> movies = snapshot.data!;
            if (movies.isEmpty) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: SvgPicture.asset('assets/images/empty.svg'),
                  ),
                  Text(
                    'There is no movie yet!',
                    style: typography.h4SemiBold
                        .copyWith(color: AppColors.textWhite),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Text(
                      'Find your movie by Type title, categories, years, etc ',
                      style: typography.h4Regular
                          .copyWith(color: AppColors.textWhite),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              );
            } else {
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
          }
        },
      ),
    );
  }
}
