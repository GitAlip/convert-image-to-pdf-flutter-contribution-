import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const Color primary = Color(0xFFFF1744); // Colors.redAccent[400]
  static const Color white = Colors.white;
  static const Color black = Colors.black;
}

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.white,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.white,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: AppColors.primary),
        titleTextStyle: GoogleFonts.raleway(
          color: AppColors.primary,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
      textTheme: TextTheme(
        bodyMedium: GoogleFonts.pangolin(fontSize: 16),
        headlineMedium: GoogleFonts.raleway(
          fontSize: 26, 
          color: AppColors.black,
          fontWeight: FontWeight.bold
        ),
      ),
      useMaterial3: true,
    );
  }
}
