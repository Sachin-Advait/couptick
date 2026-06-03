import 'package:flutter/material.dart';

class Responsive {
  static double width(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double height(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  // Font sizes that scale with screen width
  static double fontSize(BuildContext context, double size) {
    double screenWidth = width(context);
    // Base width is 375 (iPhone SE/8 size)
    double scaleFactor = screenWidth / 375;
    return size * scaleFactor;
  }

  // Padding/margin that scales with screen
  static double spacing(BuildContext context, double space) {
    double screenWidth = width(context);
    double scaleFactor = screenWidth / 375;
    return space * scaleFactor;
  }

  // Icon sizes
  static double iconSize(BuildContext context, double size) {
    double screenWidth = width(context);
    double scaleFactor = screenWidth / 375;
    return size * scaleFactor;
  }

  // For images and containers
  static double dimension(BuildContext context, double dimension) {
    double screenWidth = width(context);
    double scaleFactor = screenWidth / 375;
    return dimension * scaleFactor;
  }

  // Check if screen is small
  static bool isSmallScreen(BuildContext context) {
    return width(context) < 375;
  }

  // Check if screen is large
  static bool isLargeScreen(BuildContext context) {
    return width(context) > 600;
  }

  // Adaptive value based on screen size
  static T adaptive<T>(
    BuildContext context, {
    required T mobile,
    T? tablet,
    T? desktop,
  }) {
    double screenWidth = width(context);
    if (screenWidth > 900 && desktop != null) {
      return desktop;
    } else if (screenWidth > 600 && tablet != null) {
      return tablet;
    }
    return mobile;
  }
}
