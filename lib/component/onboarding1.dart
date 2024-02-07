import 'package:cinemax/style_guide/app_colors.dart';
import 'package:cinemax/style_guide/app_typography.dart';
import 'package:flutter/material.dart';

class OnboardingV1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                top: 90,
                left: 90,
                child: Container(
                  width: 226,
                  height: 226,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.secondaryOrange,
                  ),
                ),
              ),
              _buildCircle(50, 20, 30, AppColors.secondaryOrange),
              _buildCircle(250, 320, 30, AppColors.secondaryOrange),
              _buildCircle(100, 320, 10, const Color(0xFF94D4FF)),
              _buildCircle(60, 300, 10, const Color(0xFF94D4FF)),
              _buildCircle(250, 20, 10, const Color(0xFF94D4FF)),
              _buildCircle(320, 60, 10, const Color(0xFF94D4FF)),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Image.asset(
                  'assets/images/onBoarding1.png',
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
                    style:
                        AppTypography.h1SemiBold.copyWith(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 8),
                Center(
                  child: Text(
                    'Semper in cursus magna et eu varius nunc adipiscing. Elementum justo, laoreet id sem semper parturient. ',
                    style: AppTypography.h5Medium.copyWith(color: Colors.white),
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
