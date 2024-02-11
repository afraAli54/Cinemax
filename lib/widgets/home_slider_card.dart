import 'package:cinemax/style_guide/app_colors.dart';
import 'package:cinemax/style_guide/app_typography.dart';
import 'package:flutter/material.dart';

class HomeSliderCard extends StatelessWidget {
  final String movieName;
  final String movieDate;
  final String posterUrl;

  HomeSliderCard({
    required this.movieName,
    required this.movieDate,
    required this.posterUrl,
  });

  @override
  Widget build(BuildContext context) {
    AppTypography typography = AppTypography();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ListView(
        padding: const EdgeInsets.only(top: 10),
        children: [
          Container(
            height: 200,
            width: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              image: DecorationImage(
                image: NetworkImage(posterUrl),
                fit: BoxFit.cover,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 140,
                        left: 20,
                      ),
                      child: Text(
                        movieName,
                        style: typography.h4SemiBold
                            .copyWith(color: AppColors.textWhite),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Text(
                      "On $movieDate",
                      style: typography.h6Medium
                          .copyWith(color: AppColors.textWhite),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
