import 'package:carousel_slider/carousel_slider.dart';
import 'package:cinemax/style_guide/app_colors.dart';
import 'package:cinemax/style_guide/app_typography.dart';
import 'package:cinemax/widgets/movie_view.dart';
import 'package:flutter/material.dart';

class OnboardingV2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AppTypography typography = AppTypography();
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 50),
        SizedBox(
          width: double.infinity,
          child: CarouselSlider.builder(
              itemCount: 10,
              options: CarouselOptions(
                height: 300,
                autoPlay: true,
                viewportFraction: 0.5,
                enlargeCenterPage: true,
                autoPlayCurve: Curves.fastOutSlowIn,
                autoPlayAnimationDuration: Duration(seconds: 1),
              ),
              itemBuilder: (context, itemIndex, PageViewIndex) {
                return MovieView();
              }),
        ),
        //MovieView(),
        const SizedBox(height: 50),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Container(
            height: 300,
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: AppColors.textBlack,
              borderRadius: BorderRadius.circular(32.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    'Offers ad-free viewing of high quality',
                    style: typography.h1SemiBold.copyWith(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 8),
                Center(
                  child: Text(
                    'Semper in cursus magna et eu varius nunc adipiscing. Elementum justo, laoreet id sem semper parturient. ',
                    style: typography.h5Medium.copyWith(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Positioned _buildCircle(double top, double left, double size, Color color) {
    return Positioned(
      top: top,
      left: left,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
        ),
      ),
    );
  }
}
