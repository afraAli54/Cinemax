import 'dart:convert';

import 'package:cinemax/model/movie_model.dart';
import 'package:cinemax/style_guide/app_colors.dart';
import 'package:cinemax/style_guide/app_typography.dart';
import 'package:cinemax/widgets/movie_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String userName = '';

  @override
  void initState() {
    super.initState();
    fetchUserName();
    fetchPopularMovies();
  }

  Future<void> fetchUserName() async {
    User? user = FirebaseAuth.instance.currentUser;
    final DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(user?.uid)
        .get();

    setState(() {
      userName = userSnapshot['name'];
    });
  }

  Future<List<Movie>> fetchPopularMovies() async {
    const apiKey = '45a1ee9c5a52396669dced36b29a6d61';
    const url = 'https://api.themoviedb.org/3/movie/popular?api_key=$apiKey';

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

  @override
  Widget build(BuildContext context) {
    AppTypography typography = AppTypography();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        //elevation: 0,
        flexibleSpace: Container(
          height: 200,
          width: 200,
          padding: const EdgeInsets.only(left: 20.0),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage:
                    AssetImage('assets/images/profile-picture.png'),
                radius: 20,
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
      backgroundColor: AppColors.primaryDark,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
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
            child: PageView(
              children: [],
            ),
          ),
          SizedBox(height: 16),
          Text(
            'Most Popular',
            style: typography.h4SemiBold.copyWith(color: AppColors.textWhite),
          ),
          SizedBox(height: 8),
          Expanded(
            child: FutureBuilder<List<Movie>>(
              future: fetchPopularMovies(),
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
                  return CircularProgressIndicator();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
