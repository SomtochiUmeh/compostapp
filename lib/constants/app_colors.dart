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
  static Color primaryLight =
      senseOrange.withValues(alpha: 0.15); // Subtle orange
  static Color primaryMedium = senseOrange.withValues(alpha: 0.6);
  static Color primaryDark = const Color(0xFFD14805);

  static Color secondaryLight = senseRed.withValues(alpha: 0.2);
  static Color secondaryMedium = senseRed.withValues(alpha: 0.6);
  static Color secondaryDark = const Color(0xFFB01529);

  // Premium gradient backgrounds
  static LinearGradient get backgroundGradient => LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          senseOrange.withValues(alpha: 0.08), // Very light orange at top
          white, // White at bottom
        ],
      );

  static LinearGradient get navBarGradient => LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          senseOrange.withValues(alpha: 0.12), // Slightly more orange
          senseOrange.withValues(alpha: 0.06), // Very light orange
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
