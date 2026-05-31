import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  // Backgrounds
  static const Color backgroundDark = Color(0xFF0D1117);
  static const Color surfaceDark = Color(0xFF161B22);
  static const Color navBarDark = Color(0xFF1F2022);
  static const Color cardDark = Color(0xFF1F2022);

  // Accents
  static const Color accentBlue = Color(0xFF398AD9);
  static const Color accentCyan = Color(0xFF00D4FF);
  static const Color accentPurple = Color(0xFF7C3AED);
  static const Color accentPink = Color(0xFFFF4081);
  static const Color gold = Color(0xFFFFD700);

  // Text
  static const Color textPrimary = Colors.white;
  static const Color textSecondary = Color(0xFF8F8F8F);
  static const Color textMuted = Color(0xFF6B7280);

  // Status
  static const Color success = Color(0xFF22C55E);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);

  // Gradients
  static const List<Color> primaryGradient = [accentBlue, accentCyan];

  static const List<Color> xpGradient = [accentPurple, accentPink];

  static const List<Color> streakGradient = [gold, Color(0xFFFF6B35)];

  static const List<Color> cardOverlay = [Colors.transparent, Colors.black87];
}

class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.backgroundDark,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.accentBlue,
        secondary: AppColors.accentCyan,
        surface: AppColors.surfaceDark,
        error: AppColors.error,
      ),
      textTheme: GoogleFonts.fredokaTextTheme(
        ThemeData(brightness: Brightness.dark).textTheme.copyWith(
          displayLarge: const TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
          displayMedium: const TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
          displaySmall: const TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
          headlineLarge: const TextStyle(color: AppColors.textPrimary),
          headlineMedium: const TextStyle(color: AppColors.textPrimary),
          headlineSmall: const TextStyle(color: AppColors.textPrimary),
          titleLarge: const TextStyle(color: AppColors.textPrimary),
          titleMedium: const TextStyle(color: AppColors.textPrimary),
          titleSmall: const TextStyle(color: AppColors.textPrimary),
          bodyLarge: const TextStyle(color: AppColors.textPrimary),
          bodyMedium: const TextStyle(color: AppColors.textPrimary),
          bodySmall: const TextStyle(color: AppColors.textSecondary),
          labelLarge: const TextStyle(color: AppColors.textPrimary),
          labelMedium: const TextStyle(color: AppColors.textPrimary),
          labelSmall: const TextStyle(color: AppColors.textSecondary),
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.navBarDark,
        elevation: 0,
        centerTitle: false,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.navBarDark,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.accentBlue,
        unselectedItemColor: AppColors.textSecondary,
      ),
      tabBarTheme: const TabBarThemeData(
        dividerColor: Colors.transparent,
        indicatorColor: AppColors.accentBlue,
        labelColor: AppColors.accentBlue,
        unselectedLabelColor: AppColors.textSecondary,
      ),
      cardTheme: CardThemeData(
        color: AppColors.cardDark,
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.backgroundDark,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        hintStyle: const TextStyle(color: AppColors.textSecondary),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.accentBlue,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        ),
      ),
    );
  }
}
