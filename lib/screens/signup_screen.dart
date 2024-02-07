import 'package:cinemax/style_guide/app_colors.dart';
import 'package:cinemax/style_guide/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool isChecked = false;

  void toggleCheckbox() {
    setState(() {
      isChecked = !isChecked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryDark,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 10),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, 'login-SignUpPage');
                    },
                    child: Container(
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
                  const SizedBox(
                    width: 100,
                  ),
                  Text(
                    "Sign Up",
                    style:
                        AppTypography.h4SemiBold.copyWith(color: Colors.white),
                  )
                ],
              ),
            ),
            Text(
              "Let’s get started",
              style: AppTypography.h2SemiBold.copyWith(color: Colors.white),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 100),
              child: Text(
                "The latest movies and series are here",
                style: AppTypography.h6Medium.copyWith(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 100),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.0),
                    borderSide: BorderSide(color: AppColors.primarySoft),
                    gapPadding: 10,
                  ),
                  labelText: 'Full Name',
                  hintText: 'Enter Your Name',
                ),
                style: AppTypography.h6Medium
                    .copyWith(color: AppColors.textWhiteGrey),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.0),
                    borderSide: BorderSide(color: AppColors.primarySoft),
                    gapPadding: 10,
                  ),
                  labelText: 'Email Address',
                  hintText: 'Enter Your Email',
                ),
                style: AppTypography.h6Medium
                    .copyWith(color: AppColors.textWhiteGrey),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.0),
                    borderSide: BorderSide(color: AppColors.primarySoft),
                    gapPadding: 10,
                  ),
                  labelText: 'Password',
                  hintText: 'Enter Your Password',
                  suffixIcon: Icon(Icons.visibility_off),
                ),
                style: AppTypography.h6Medium
                    .copyWith(color: AppColors.textWhiteGrey),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: toggleCheckbox,
                      child: Container(
                        width: 24,
                        height: 24,
                        child: isChecked
                            ? SvgPicture.asset(
                                'assets/images/Radio.svg',
                                fit: BoxFit.contain,
                              )
                            : SvgPicture.asset(
                                'assets/images/Checkbox.svg',
                                fit: BoxFit.contain,
                              ),
                      ),
                    ),
                  ),
                  Flexible(
                    child: Text(
                      "I agree to the Terms and Services and Privacy Policy",
                      style: AppTypography.h6Medium
                          .copyWith(color: AppColors.textGrey),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 16,
            ),
            SizedBox(
              height: 60,
              width: 350,
              child: ElevatedButton(
                onPressed: () {},
                child: Text("Sign UP",
                    style: AppTypography.h3Medium
                        .copyWith(color: AppColors.textWhite)),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(AppColors.primaryBlue),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
