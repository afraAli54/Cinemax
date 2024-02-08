import 'package:cinemax/style_guide/app_colors.dart';
import 'package:cinemax/style_guide/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String text;

  const CustomAppBar({required this.text, super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    AppTypography typography = AppTypography();
    return AppBar(
      backgroundColor: Colors.transparent,
      centerTitle: true,
      title: Text(
        text,
        style: typography.h4SemiBold.copyWith(color: Colors.white),
      ),
      leading: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, '/login-SignUpPage');
        },
        child: Container(
          margin: const EdgeInsets.all(5),
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
    );
  }
}
