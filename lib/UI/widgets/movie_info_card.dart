import 'package:cinemax/UI/screens/movie_details.dart';
import 'package:cinemax/style_guide/app_colors.dart';
import 'package:cinemax/style_guide/app_typography.dart';
import 'package:flutter/material.dart';

class MovieInfoCard extends StatelessWidget {
  final String movieName;
  final String posterUrl;
  final String genre;
  final int movieId;

  const MovieInfoCard({
    Key? key,
    required this.movieName,
    required this.posterUrl,
    required this.genre,
    required this.movieId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppTypography typography = AppTypography();
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MovieDetailsScreen(
              movieId: movieId,
            ),
          ),
        );
      },
      child: Container(
        height: 170,
        width: 150,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                posterUrl,
                width: 100,
                height: 150,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movieName,
                    style: typography.h4SemiBold
                        .copyWith(color: AppColors.textWhite),
                  ),
                  SizedBox(height: 8),
                  Text(
                    genre,
                    style: typography.h4Regular
                        .copyWith(color: AppColors.textWhite),
                  ),
                  SizedBox(height: 8),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
