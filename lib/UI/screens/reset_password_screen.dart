import 'package:cinemax/style_guide/app_colors.dart';
import 'package:cinemax/style_guide/app_typography.dart';
import 'package:cinemax/UI/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ResetPasswordScreen extends StatelessWidget {
  ResetPasswordScreen({super.key});

  final TextEditingController _useremailController = TextEditingController();

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
                      Navigator.pushNamed(context, '/loginPage');
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
              "Reset Password",
              style: typography.h1SemiBold.copyWith(color: Colors.white),
            ),
            Text(
              "Recover your account password",
              style: typography.h6Medium.copyWith(color: Colors.white),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 70),
            CustomTextField(
              labelText: 'Email Address',
              hintText: 'Enter Your Email',
              textController: _useremailController,
            ),
            SizedBox(
              height: 16,
            ),
            SizedBox(
              height: 60,
              width: 350,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/createPassword');
                },
                child: Text("Next",
                    style: typography.h3Medium
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
