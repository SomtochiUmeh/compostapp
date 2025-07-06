import 'package:flutter/material.dart';

/// Centralized color constants for the Sense brand
class AppColors {
  // Sense Brand Colors
  static const Color senseRed = Color(0xFFDC1C3E);
  static const Color senseOrange = Color(0xFFEA5B0C);
  static const Color black = Color(0xFF000000);
  static const Color white = Color(0xFFFFFFFF);

  // Derived colors for UI components
  static const Color primary = senseRed;
  static const Color secondary = senseOrange;
  static const Color surface = white;
  static const Color background = white;
  static const Color onPrimary = white;
  static const Color onSecondary = white;
  static const Color onSurface = black;
  static const Color onBackground = black;

  // Utility colors with opacity
  static const Color primaryLight =
      Color.fromARGB(38, 234, 91, 12); // Subtle orange (15% opacity)
  static const Color primaryMedium = Color.fromARGB(153, 234, 91, 12); // 60% opacity
  static Color primaryDark = const Color(0xFFD14805);

  static const Color secondaryLight = Color.fromARGB(51, 220, 28, 62); // 20% opacity
  static const Color secondaryMedium = Color.fromARGB(153, 220, 28, 62); // 60% opacity
  static Color secondaryDark = const Color(0xFFB01529);

  // Premium gradient backgrounds
  static LinearGradient get backgroundGradient => const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color.fromARGB(20, 234, 91, 12), // Very light orange at top (8% opacity)
          white, // White at bottom
        ],
      );

  static LinearGradient get navBarGradient => const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color.fromARGB(31, 234, 91, 12), // Slightly more orange (12% opacity)
          Color.fromARGB(15, 234, 91, 12), // Very light orange (6% opacity)
        ],
      );

  // Text colors
  static const Color primaryText = black;
  static const Color secondaryText = Color(0xFF666666);
  static const Color lightText = Color(0xFF999999);

  // Status colors
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFF9800);
  static const Color error = Color(0xFFD32F2F);
  static const Color info = Color(0xFF2196F3);
}
