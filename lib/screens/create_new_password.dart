import 'package:cinemax/style_guide/app_colors.dart';
import 'package:cinemax/style_guide/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CreatePassword extends StatelessWidget {
  const CreatePassword({super.key});

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
                      Navigator.pushNamed(context, 'resetPassword');
                    },
                    child: Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        color: AppColors.primarySoft,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 16),
                      child: SvgPicture.asset(
                        "assets/images/arrow-back.svg",
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 100,
                  ),
                ],
              ),
            ),
            Text(
              "Create New Password",
              style: AppTypography.h1SemiBold.copyWith(color: Colors.white),
            ),
            Text(
              "Enter your new password",
              style: AppTypography.h6Medium.copyWith(color: Colors.white),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.0),
                    borderSide: BorderSide(color: AppColors.primarySoft),
                    gapPadding: 10,
                  ),
                  labelText: 'New Password',
                  hintText: 'Enter Your New Password',
                  suffixIcon: Icon(Icons.visibility_off),
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
                  labelText: 'Confirm Password',
                  hintText: 'Confirm Your Password',
                  suffixIcon: Icon(Icons.visibility_off),
                ),
                style: AppTypography.h6Medium
                    .copyWith(color: AppColors.textWhiteGrey),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            SizedBox(
              height: 60,
              width: 350,
              child: ElevatedButton(
                onPressed: () {},
                child: Text("Reset",
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
