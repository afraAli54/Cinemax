import 'package:cinemax/style_guide/app_colors.dart';
import 'package:cinemax/UI/widgets/splash_view.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.primaryDark,
      body: SplashView(),
    );
  }
}
