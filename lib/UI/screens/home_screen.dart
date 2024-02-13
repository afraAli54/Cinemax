import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cinemax/domain/model/movie_model.dart';
import 'package:cinemax/UI/screens/profile_screen.dart';
import 'package:cinemax/provider/page_provider.dart';
import 'package:cinemax/style_guide/app_colors.dart';
import 'package:cinemax/style_guide/app_typography.dart';
import 'package:cinemax/UI/widgets/home_slider_card.dart';
import 'package:cinemax/UI/widgets/movie_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String userName = '';
  String movieAPI = '';

  int _currentSlideIndex = 0;

  @override
  void initState() {
    super.initState();
    fetchMovies(movieAPI);
  }

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
      throw Exception('Failed to fetch popular movies');
    }
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      height: 8,
      width: isActive ? 24 : 8,
      decoration: BoxDecoration(
        color: isActive ? AppColors.primaryBlue : Colors.grey,
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    AppTypography typography = AppTypography();
    final userName = ModalRoute.of(context)?.settings.arguments as String?;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        //elevation: 0,
        flexibleSpace: Container(
          height: 200,
          width: 200,
          padding: const EdgeInsets.only(left: 20.0, top: 20),
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  Provider.of<PageProvider>(context, listen: false)
                      .setCurrentPage(3, 'Profile');
                },
                child: CircleAvatar(
                  backgroundImage:
                      AssetImage('assets/images/profile-picture.png'),
                  radius: 20,
                ),
              ),
              SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Hello, $userName',
                    style: typography.h4SemiBold
                        .copyWith(color: AppColors.textWhite),
                  ),
                  Text(
                    'Let’s stream your favorite movie',
                    style:
                        typography.h6Medium.copyWith(color: AppColors.textGrey),
                  ),
                ],
              ),
              const SizedBox(
                width: 70,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  width: 32,
                  height: 32,
                  color: AppColors.primarySoft,
                  child: SvgPicture.asset(
                    "assets/images/heart.svg",
                    height: 24,
                    width: 24,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      //bottomNavigationBar: BottomNavigationBarWidget(),
      backgroundColor: AppColors.primaryDark,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: GestureDetector(
              onTap: () {
                Provider.of<PageProvider>(context, listen: false)
                    .setCurrentPage(1, 'Search');
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  color: AppColors.primarySoft,
                ),
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Icon(Icons.search, color: AppColors.textDarkGrey),
                    SizedBox(width: 8),
                    Text(
                      'Search a title...',
                      style: TextStyle(color: AppColors.textDarkGrey),
                    ),
                    Spacer(),
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
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Movie>>(
              future:
                  fetchMovies('https://api.themoviedb.org/3/discover/movie'),
              builder:
                  (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {
                if (snapshot.hasData) {
                  final List<Movie> movies = snapshot.data!;
                  return Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: SizedBox(
                      width: double.infinity,
                      child: CarouselSlider.builder(
                        itemCount: 3,
                        itemBuilder: (context, index, _) {
                          final Movie movie = movies[index];
                          return HomeSliderCard(
                            movieName: movie.title,
                            movieDate: movie.releaseDate,
                            posterUrl:
                                'https://image.tmdb.org/t/p/w500${movie.backdropPath}',
                          );
                        },
                        options: CarouselOptions(
                          viewportFraction: 0.8,
                          initialPage: 0,
                          onPageChanged: (index, _) {
                            setState(() {
                              _currentSlideIndex = index;
                            });
                          },
                        ),
                      ),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(3, (index) {
              return _indicator(index == _currentSlideIndex);
            }),
          ),
          const SizedBox(height: 16),
          Text(
            'Most Popular',
            style: typography.h4SemiBold.copyWith(color: AppColors.textWhite),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: FutureBuilder<List<Movie>>(
              future: fetchMovies('https://api.themoviedb.org/3/movie/popular'),
              builder:
                  (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {
                if (snapshot.hasData) {
                  final List<Movie> movies = snapshot.data!;
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: movies.length,
                    itemBuilder: (BuildContext context, int index) {
                      final Movie movie = movies[index];
                      return Padding(
                        padding: EdgeInsets.only(right: 8),
                        child: MovieCard(
                          posterUrl:
                              'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                          movieName: movie.title,
                          genre: 'Action', // Replace with actual genre
                        ),
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class DotIndicator extends StatelessWidget {
  final bool isActive;
  DotIndicator(this.isActive);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      height: 8,
      width: isActive ? 24 : 8,
      decoration: BoxDecoration(
        color: isActive ? AppColors.primaryBlue : Colors.grey,
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
    );
  }
}
