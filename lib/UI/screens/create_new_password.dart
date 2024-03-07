import 'package:cinemax/style_guide/app_colors.dart';
import 'package:cinemax/style_guide/app_typography.dart';
import 'package:cinemax/UI/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CreatePassword extends StatelessWidget {
  CreatePassword({super.key});

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmedPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    AppTypography typography = AppTypography();
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
                      Navigator.pushNamed(context, '/resetPassword');
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
              style: typography.h1SemiBold.copyWith(color: Colors.white),
            ),
            Text(
              "Enter your new password",
              style: typography.h6Medium.copyWith(color: Colors.white),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 50),
            CustomTextField(
              labelText: 'New Password',
              hintText: 'Enter Your New Password',
              isPassword: true,
              textController: _passwordController,
            ),
            CustomTextField(
              labelText: 'Confirm Password',
              hintText: 'Confirm Your Password',
              isPassword: true,
              textController: _confirmedPasswordController,
            ),
            const SizedBox(
              height: 50,
            ),
            SizedBox(
              height: 60,
              width: 350,
              child: ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(AppColors.primaryBlue),
                ),
                child: Text("Reset",
                    style: typography.h3Medium
                        .copyWith(color: AppColors.textWhite)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
