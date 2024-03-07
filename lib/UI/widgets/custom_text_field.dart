import 'package:cinemax/style_guide/app_colors.dart';
import 'package:cinemax/style_guide/app_typography.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String labelText;
  final String hintText;
  final bool isPassword;
  final TextEditingController textController;

  const CustomTextField({
    Key? key,
    required this.labelText,
    required this.hintText,
    this.isPassword = false,
    required this.textController,
  }) : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    AppTypography typography = AppTypography();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: TextFormField(
        obscureText: widget.isPassword ? obscureText : false,
        validator: (data) {
          if (data!.isEmpty) {
            return 'Field is required';
          }
          return null; // Return null if the validation is successful
        },
        controller: widget.textController,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50.0),
            borderSide: const BorderSide(color: AppColors.primarySoft),
            gapPadding: 10,
          ),
          labelText: widget.labelText,
          hintText: widget.hintText,
          suffixIcon: widget.isPassword
              ? GestureDetector(
                  onTap: () {
                    setState(() {
                      obscureText = !obscureText;
                    });
                  },
                  child: Icon(
                    obscureText ? Icons.visibility_off : Icons.visibility,
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
