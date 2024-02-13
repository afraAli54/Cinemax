import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTypography {
  final String? montserratFont =  GoogleFonts.montserrat().fontFamily ;

  static final AppTypography _typography = AppTypography._internal() ;

  factory AppTypography (){
    return _typography ;
  }

  AppTypography._internal();


  TextStyle get h1SemiBold => TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        fontFamily: montserratFont,
      );

  TextStyle get h2SemiBold => TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        fontFamily: montserratFont,
      );

  TextStyle get h3SemiBold => TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        fontFamily: montserratFont,
      );

  TextStyle get h4SemiBold => TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        fontFamily: montserratFont,
      );

  TextStyle get h5SemiBold => TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        fontFamily: montserratFont,
      );

  TextStyle get h6SemiBold => TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        fontFamily: montserratFont,
      );

  TextStyle get h7SemiBold => TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w600,
        fontFamily: montserratFont,
      );

  TextStyle get h1Medium => TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w500,
        fontFamily: montserratFont,
      );

  TextStyle get h2Medium => TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w500,
        fontFamily: montserratFont,
      );

  TextStyle get h3Medium => TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        fontFamily: montserratFont,
      );

  TextStyle get h4Medium => TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        fontFamily: montserratFont,
      );

  TextStyle get h5Medium => TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        fontFamily: montserratFont,
      );

  TextStyle get h6Medium => TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        fontFamily: montserratFont,
      );

  TextStyle get h7Medium => TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w500,
        fontFamily: montserratFont,
      );

  TextStyle get h1Regular => TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.normal,
        fontFamily: montserratFont,
      );

  TextStyle get h2Regular => TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.normal,
        fontFamily: montserratFont,
      );

  TextStyle get h3Regular => TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.normal,
        fontFamily: montserratFont,
      );

  TextStyle get h4Regular => TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        fontFamily: montserratFont,
      );

  TextStyle get h5Regular => TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        fontFamily: montserratFont,
      );

  TextStyle get h6Regular => TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.normal,
        fontFamily: montserratFont,
      );

  TextStyle get h7Regular => TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.normal,
        fontFamily: montserratFont,
      );
}
