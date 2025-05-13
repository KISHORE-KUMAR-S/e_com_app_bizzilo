import 'package:flutter/material.dart' show BuildContext, MediaQuery;

extension ContextExtensions on BuildContext {
  double get screenWidth => MediaQuery.of(this).size.width;
  double get screenHeight => MediaQuery.of(this).size.height;

  bool get isTablet => screenWidth <= 1025 && screenWidth >= 770;
  bool get isMobile => screenWidth <= 770;
  bool get isDesktop => screenWidth > 1025;

  getResponsiveValue<T>(List<T> number) {
    if (isMobile) return number[0];
    if (isTablet) return number[1];

    return number[2];
  }

  double responiveSize({
    required double xs,
    required double lg,
    double? sm,
    double? md,
    double? xl,
  }) {
    if (isMobile) return xs;
    if (isTablet) return sm ?? (md ?? xs);
    if (isDesktop) return md ?? lg;
    return xl ?? lg;
  }
}
