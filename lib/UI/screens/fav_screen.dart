import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cinemax/bloc/fav_bloc/fav_bloc.dart';
import 'package:cinemax/bloc/fav_bloc/fav_event.dart';
import 'package:cinemax/bloc/fav_bloc/fav_state.dart';
import 'package:cinemax/domain/model/movie_model.dart';
import 'package:cinemax/UI/widgets/movie_info_card.dart';
import 'package:cinemax/style_guide/app_colors.dart';
import 'package:cinemax/style_guide/app_typography.dart';
import 'package:flutter_svg/svg.dart';

class FavScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavMovieBloc(),
      child: _FavScreenContent(),
    );
  }
}

class _FavScreenContent extends StatefulWidget {
  @override
  _FavScreenContentState createState() => _FavScreenContentState();
}

class _FavScreenContentState extends State<_FavScreenContent> {
  late FavMovieBloc _favMovieBloc;

  @override
  void initState() {
    super.initState();
    _favMovieBloc = BlocProvider.of<FavMovieBloc>(context);
    _favMovieBloc.add(LoadFavoriteMoviesEvent());
  }

  @override
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
      body: BlocBuilder<FavMovieBloc, FavMovieState>(
        builder: (context, state) {
          if (state is FavMovieInitialState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is FavMovieLoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is FavMovieLoadedState) {
            final List<Movie> movies = state.movies;
            if (movies.isEmpty) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: SvgPicture.asset('assets/images/empty.svg'),
                  ),
                  Text(
                    'There are no favorite movies yet!',
                    style: typography.h4SemiBold
                        .copyWith(color: AppColors.textWhite),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Text(
                      'Find your favorite movies and add them to your favorites list.',
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
          } else if (state is FavMovieErrorState) {
            return Center(
              child: Text(
                'Error: ${state.errorMessage}',
                style:
                    typography.h4SemiBold.copyWith(color: AppColors.textWhite),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }

  @override
  void dispose() {
    _favMovieBloc.close();
    super.dispose();
  }
}
