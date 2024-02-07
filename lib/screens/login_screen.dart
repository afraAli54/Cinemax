import 'package:cinemax/style_guide/app_colors.dart';
import 'package:cinemax/style_guide/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          "Login",
          style:
          AppTypography.h4SemiBold.copyWith(color: Colors.white),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, 'login-SignUpPage');
          },
          child: Container(
            margin: EdgeInsets.all(5),
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
      ),
      backgroundColor: AppColors.primaryDark,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 50,) ,
            Text(
              "Hi , Tiffany",
              style: AppTypography.h2SemiBold.copyWith(color: Colors.white),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 100),
              child: Text(
                "Welcome back! Please enter your details.",
                style: AppTypography.h6Medium.copyWith(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 70),
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
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Flexible(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, 'resetPassword');
                      },
                      child: Text(
                        "Forget Password?",
                        style: AppTypography.h6Medium
                            .copyWith(color: AppColors.primaryBlue),
                      ),
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
                child: Text("Login",
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
