import 'package:cinemax/style_guide/app_colors.dart';
import 'package:cinemax/style_guide/app_typography.dart';
import 'package:flutter/material.dart';

class MovieCard extends StatelessWidget {
  final String posterUrl;
  final String movieName;
  final String genre;

  MovieCard({
    required this.posterUrl,
    required this.movieName,
    required this.genre,
  });

  @override
  Widget build(BuildContext context) {
    AppTypography typography = AppTypography();
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 4),
      child: Container(
        height: 230,
        width: 135,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: AppColors.primarySoft.withOpacity(0.8),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Column(
            children: [
              Expanded(
                child: Image.network(
                  posterUrl,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                  ),
                ),
                padding: EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      movieName,
                      style: typography.h5SemiBold
                          .copyWith(color: AppColors.textWhite),
                    ),
                    SizedBox(height: 4),
                    Text(
                      genre,
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
