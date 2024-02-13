import 'package:cinemax/UI/screens/login_sign_up_screen.dart';
import 'package:cinemax/style_guide/app_colors.dart';
import 'package:cinemax/style_guide/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key});

  Future<void> _logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('session_id');
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginSignUpScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    AppTypography typography = AppTypography();
    final userName = ModalRoute.of(context)?.settings.arguments as String?;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          'Profile',
          style: typography.h4SemiBold.copyWith(color: AppColors.textWhite),
        ),
      ),
      backgroundColor: AppColors.primaryDark,
      body: Padding(
        padding: const EdgeInsets.only(left: 30, right: 20),
        child: Column(
          children: [
            Container(
              height: 100,
              width: 300,
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage:
                        AssetImage('assets/images/profile-picture.png'),
                    radius: 27,
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '$userName',
                          style: typography.h4SemiBold
                              .copyWith(color: AppColors.textWhite),
                        ),
                        Text(
                          '$userName@gmail.com',
                          style: typography.h6Medium
                              .copyWith(color: AppColors.textGrey),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 70,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      width: 32,
                      height: 32,
                      color: AppColors.primarySoft,
                      child: SvgPicture.asset(
                        "assets/images/Edit.svg",
                        height: 20,
                        width: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 400,
            ),
            GestureDetector(
              onTap: () => _logout(context),
              child: Container(
                width: 327,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: AppColors.primaryDark,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: AppColors.primaryBlue,
                    width: 1,
                  ),
                ),
                child: Center(
                  child: Text(
                    'Log Out',
                    style: typography.h4SemiBold
                        .copyWith(color: AppColors.primaryBlue),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
