import 'package:cinemax/style_guide/app_colors.dart';
import 'package:cinemax/style_guide/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LoginSignUpScreen extends StatelessWidget {
  const LoginSignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AppTypography typography = AppTypography();
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: AppColors.primaryDark,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SvgPicture.asset("assets/images/Cinamex_Logo.svg"),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 100),
                child: Text(
                  "Enter your registered Phone Number to Sign Up",
                  style:
                      typography.h5SemiBold.copyWith(color: AppColors.textGrey),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const SizedBox(
              height: 80,
            ),
            SizedBox(
              height: 50,
              width: 350,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/signUpPage');
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(AppColors.primaryBlue),
                ),
                child: const Text("Sign UP",
                    style: TextStyle(color: Colors.white)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "I already have an account?",
                    style: typography.h4SemiBold
                        .copyWith(color: AppColors.textGrey),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/loginPage');
                    },
                    child: Text(
                      '  Login',
                      style: typography.h4SemiBold
                          .copyWith(color: AppColors.primaryBlue),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
