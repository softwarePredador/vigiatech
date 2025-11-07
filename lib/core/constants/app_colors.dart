import 'package:flutter/material.dart';

/// VIGIATECH Color Palette
/// Industrial IoT Monitoring App - Dark Mode Theme
class AppColors {
  // Primary Colors
  /// #24324F - Industrial dark blue (Main background)
  static const Color primaryBackground = Color(0xFF24324F);
  
  /// #1A1F2C - Neutral dark gray (Navigation areas, panels, input fields)
  static const Color secondaryBackground = Color(0xFF1A1F2C);
  
  /// #E6F7F4 - Ice white (Main text, titles, labels)
  static const Color primaryText = Color(0xFFE6F7F4);
  
  /// #ADFBED - Tech light green (Primary buttons, "Normal" status icons)
  static const Color accent = Color(0xFFADFBED);
  
  /// #3DB3C7 - Vibrant light blue (Warning tags, alert icons, link text)
  static const Color warning = Color(0xFF3DB3C7);
  
  /// #6EE7E7 - Soft cyan blue (Graph lines, secondary icons)
  static const Color secondary = Color(0xFF6EE7E7);

  // Status Colors
  static const Color statusNormal = accent;
  static const Color statusWarning = warning;
  static const Color statusCritical = Color(0xFFFF6B6B);

  // Opacity Variations
  static Color primaryTextDimmed = primaryText.withOpacity(0.6);
  static Color secondaryTextDimmed = primaryText.withOpacity(0.4);
}
