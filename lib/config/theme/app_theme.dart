import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.backgroundDark,
      primaryColor: AppColors.primaryAccent,

      // Typography System
      textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme)
          .copyWith(
            titleLarge: GoogleFonts.inter(fontWeight: FontWeight.w500),
            titleMedium: GoogleFonts.inter(fontWeight: FontWeight.w500),
            titleSmall: GoogleFonts.inter(fontWeight: FontWeight.w500),
            bodyLarge: GoogleFonts.inter(fontWeight: FontWeight.w400),
            bodyMedium: GoogleFonts.inter(fontWeight: FontWeight.w400),
            bodySmall: GoogleFonts.inter(fontWeight: FontWeight.w400),
          ),

      // Color Scheme
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primaryAccent,
        secondary: AppColors.backgroundLight,
        surface: AppColors.backgroundLight,
        error: AppColors.critical,
        onPrimary: AppColors.textPrimary,
        onSecondary: AppColors.textPrimary,
        onSurface: AppColors.textPrimary,
        onError: AppColors.textPrimary,
      ),

      // Components Theme
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: GoogleFonts.inter(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
        iconTheme: const IconThemeData(color: AppColors.primaryAccent),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryAccent,
          foregroundColor: AppColors.textPrimary,
          textStyle: GoogleFonts.inter(fontWeight: FontWeight.w500),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.backgroundLight.withAlpha(128),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.white.withAlpha(26)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.white.withAlpha(26)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.primaryAccent),
        ),
        hintStyle: GoogleFonts.inter(color: AppColors.textSecondary),
      ),
    );
  }
}
