import 'package:cinemax/style_guide/app_colors.dart';
import 'package:cinemax/style_guide/app_typography.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final bool isPassword;
  final Function(String)? onChanged;
  final bool? obscureText;

  const CustomTextField(
      {required this.labelText,
      required this.hintText,
      this.isPassword = false,
      super.key,
      this.onChanged,
      this.obscureText = false});

  @override
  Widget build(BuildContext context) {
    AppTypography typography = AppTypography();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: TextFormField(
        obscureText: obscureText!,
        validator: (data) {
          if (data!.isEmpty) {
            return 'Field is required';
          }
          return null; // Return null if the validation is successful
        },
        onChanged: onChanged,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50.0),
            borderSide: const BorderSide(color: AppColors.primarySoft),
            gapPadding: 10,
          ),
          labelText: labelText,
          hintText: hintText,
          suffixIcon: isPassword
              ? GestureDetector(
                  onTap: () {},
                  child: Icon(
                    isPassword ? Icons.visibility_off : Icons.visibility,
                    color: Colors.grey,
                  ),
                )
              : null,
        ),
        style: typography.h6Medium.copyWith(color: Colors.white),
      ),
    );
  }
}
