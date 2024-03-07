import 'package:cinemax/component/onboarding3.dart';
import 'package:cinemax/component/onboarding1.dart';
import 'package:cinemax/component/onboarding2.dart';
import 'package:cinemax/UI/screens/splash_screen.dart';
import 'package:cinemax/style_guide/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Onboarding extends StatefulWidget {
  @override
  _OnboardingState createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryDark,
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
            children: [
              OnboardingV1(),
              OnboardingV2(),
              OnboardingV3(),
            ],
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 80),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildPageIndicator(),
                  const SizedBox(width: 150),
                  _buildNextButton(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPageIndicator() {
    List<Widget> indicators = [];
    for (int i = 0; i < 3; i++) {
      indicators.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return Row(children: indicators);
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

  Widget _buildNextButton() {
    Future<void> setOnboardingStatus() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('hasShownOnboarding', true);
    }

    return GestureDetector(
      onTap: () {
        if (_currentPage < 2) {
          _pageController.animateToPage(
            _currentPage + 1,
            duration: const Duration(milliseconds: 500),
            curve: Curves.ease,
          );
          setState(() {
            _currentPage = _currentPage + 1;
          });
        } else {
          setOnboardingStatus();
          Navigator.pushReplacementNamed(context, '/splashPage');
        }
      },
      child: Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            color: AppColors.primaryBlue,
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: const Icon(Icons.arrow_forward_ios)),
    );
  }
}
