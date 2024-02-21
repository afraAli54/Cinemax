import 'dart:convert';
import 'dart:ui';

import 'package:cinemax/domain/model/movie_model.dart';
import 'package:cinemax/style_guide/app_colors.dart';
import 'package:cinemax/style_guide/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class MovieDetailsScreen extends StatefulWidget {
  final int movieId;

  MovieDetailsScreen({required this.movieId});

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  late Future<Movie> _movieFuture;
  bool isPressed = false;

  @override
  void initState() {
    super.initState();
    _initializeState();
  }

  Future<void> _initializeState() async {
    _movieFuture = fetchMovie();
    isPressed = await getFavoriteStatus();
    setState(() {});
  }

  Future<Movie> fetchMovie() async {
    const apiKey = '45a1ee9c5a52396669dced36b29a6d61';
    final url =
        'https://api.themoviedb.org/3/movie/${widget.movieId}?api_key=$apiKey';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      final movie = Movie.fromJson(responseData);
      return movie;
    } else {
      throw Exception('Failed to fetch movie details');
    }
  }

  Future<bool> getFavoriteStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool state = prefs.getBool('favorite_${widget.movieId}') ?? false;
    print(state);
    return state;
  }

  Future<String?> getSessionId() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString('session_id');
  }

  Future<void> addToFavorites(int movieId, bool isFavorite) async {
    final apiKey = '45a1ee9c5a52396669dced36b29a6d61';
    final sessionId = await getSessionId();
    final url =
        'https://api.themoviedb.org/3/account/20973161/favorite?api_key=$apiKey&session_id=${sessionId}';
    final headers = {'Content-Type': 'application/json;charset=utf-8'};
    final body =
        '{"media_type":"movie","media_id":$movieId,"favorite":$isFavorite}';

    final response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: body,
    );

    if (response.statusCode == 201) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('favorite_$movieId', isFavorite);
    } else if (response.statusCode == 200) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('favorite_$movieId', isFavorite);
    } else {
      print(
          'Failed to update movie favorite status. Error: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    AppTypography typography = AppTypography();
    return Scaffold(
      backgroundColor: AppColors.primaryDark,
      body: FutureBuilder<Movie>(
        future: _movieFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Failed to fetch movie details'));
          } else if (snapshot.hasData) {
            final movie = snapshot.data!;
            return SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    children: [
                      SizedBox(
                        height: 500,
                        width: double.infinity,
                        child: Stack(
                          children: [
                            Image.network(
                              'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                              width: double.infinity,
                              fit: BoxFit.fill,
                            ),
                            BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                              child: Container(
                                color: Colors.transparent,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: 30,
                        //left: 20,
                        child: SizedBox(
                          width: 350,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            //mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushReplacementNamed(
                                    context,
                                    '/indexPage',
                                  );
                                },
                                child: Container(
                                  margin: const EdgeInsets.all(5),
                                  height: 40,
                                  width: 40,
                                  child: SvgPicture.asset(
                                    "assets/images/arrow-back.svg",
                                    fit: BoxFit.scaleDown,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  movie.title,
                                  style: typography.h1SemiBold
                                      .copyWith(color: AppColors.textWhite),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              GestureDetector(
                                onTap: () async {
                                  bool isFavorite = !isPressed;
                                  await addToFavorites(movie.id, isFavorite);
                                  setState(() {
                                    isPressed = isFavorite;
                                  });
                                  print(movie.id);
                                  print(isFavorite);
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Opacity(
                                    opacity: 0.8,
                                    child: Container(
                                      width: 32,
                                      height: 32,
                                      color: AppColors.primarySoft,
                                      child: SvgPicture.asset(
                                        isPressed
                                            ? "assets/images/heart.svg"
                                            : "assets/images/heartoff.svg",
                                        height: 24,
                                        width: 24,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: MediaQuery.of(context).size.height * 0.2,
                        left: MediaQuery.of(context).size.width * 0.25,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            'https://image.tmdb.org/t/p/w200${movie.posterPath}',
                            width: 200,
                            height: 287,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 8.0,
                      bottom: 8.0,
                      left: 16.0,
                      right: 16.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20),
                        Text(
                          "Story Line",
                          style: typography.h4Medium
                              .copyWith(color: AppColors.textWhite),
                        ),
                        SizedBox(height: 16),
                        Text(
                          movie.overview,
                          style: typography.h4Medium
                              .copyWith(color: AppColors.textWhite),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Action',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Center(child: Text('Failed to fetch movie details'));
          }
        },
      ),
    );
  }
}
