import 'package:flutter/material.dart';
import 'package:seeku_health_calc/utils/screen_util.dart';

class AdaptiveText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;
  final double? mobileSize;
  final double? tabletSize;
  final double? desktopSize;

  const AdaptiveText(
    this.text, {
    super.key,
    this.style,
    this.textAlign,
    this.mobileSize,
    this.tabletSize,
    this.desktopSize,
  });

  @override
  Widget build(BuildContext context) {
    // Determine base font size
    final baseFontSize = _getResponsiveFontSize(context);

    // Create text style
    final textStyle = style?.copyWith(fontSize: baseFontSize) ??
        TextStyle(fontSize: baseFontSize);

    return Text(
      text,
      style: textStyle,
      textAlign: textAlign,
    );
  }

  double _getResponsiveFontSize(BuildContext context) {
    // If specific sizes are provided, use them
    if (mobileSize != null || tabletSize != null || desktopSize != null) {
      return ScreenUtil.responsiveFontSize(
        context,
        mobile: mobileSize ?? 14,
        tablet: tabletSize ?? 16,
        desktop: desktopSize ?? 18,
      );
    }

    // If no specific sizes, use the style's font size or default
    final baseSize = style?.fontSize;

    if (baseSize != null) {
      return ScreenUtil.responsiveFontSize(
        context,
        mobile: baseSize * 0.8,
        tablet: baseSize * 0.9,
        desktop: baseSize,
      );
    }

    // Fallback to default sizes
    return ScreenUtil.responsiveFontSize(context);
  }
}
