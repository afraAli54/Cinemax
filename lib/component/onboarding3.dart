import 'package:cinemax/style_guide/app_colors.dart';
import 'package:cinemax/style_guide/app_typography.dart';
import 'package:flutter/material.dart';

class OnboardingV3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AppTypography typography = AppTypography();
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 100.0),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                top: 80,
                left: 10,
                child: Container(
                  width: 250,
                  height: 250,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.secondaryOrange,
                  ),
                ),
              ),
              _buildCircle(50, 20, 30, const Color(0xFF94D4FF)),
              _buildCircle(300, 20, 30, const Color(0xFF94D4FF)),
              _buildCircle(100, 230, 10, const Color(0xFF94D4FF)),
              _buildCircle(60, 220, 10, const Color(0xFF94D4FF)),
              _buildCircle(100, 10, 10, const Color(0xFF94D4FF)),
              _buildCircle(290, 10, 10, const Color(0xFF94D4FF)),
              _buildCircle(320, 250, 10, const Color(0xFF94D4FF)),
              ClipOval(
                child: Image.asset(
                  'assets/images/onBoarding2.png',
                  width: 259.69,
                  height: 333.14,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Container(
            height: 300,
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: AppColors.textBlack,
              borderRadius: BorderRadius.circular(32.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    'Our service brings together your favorite series',
                    style: typography.h1SemiBold.copyWith(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 8),
                Center(
                  child: Text(
                    'Semper in cursus magna et eu varius nunc adipiscing. Elementum justo, laoreet id sem semper parturient.',
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
