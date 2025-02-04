import 'package:flutter/material.dart';
import 'package:seeku_health_calc/utils/screen_util.dart';

class ReusableBgCard extends StatelessWidget {
  final Widget? cardChild;
  final double? height;
  final double? heightFactor;
  final Color? color;
  final Function()? onTap;
  final double? width;
  final EdgeInsetsGeometry padding;

  const ReusableBgCard({
    super.key,
    this.color,
    this.cardChild,
    this.onTap,
    this.width,
    this.height,
    this.heightFactor,
    this.padding = const EdgeInsets.all(16), // Default padding
  });

  @override
  Widget build(BuildContext context) {
    double? calculatedHeight;
    if (heightFactor != null) {
      calculatedHeight = MediaQuery.of(context).size.height * heightFactor!;
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width ?? _getResponsiveWidth(context),
        height: height ?? calculatedHeight,
        padding: padding, // Applied padding
        decoration: BoxDecoration(
          color: color ?? Theme.of(context).cardColor, // Use theme color
          borderRadius: BorderRadius.circular(
            ScreenUtil.responsiveFontSize(
              context,
              mobile: 10,
              tablet: 12,
              desktop: 15,
            ),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1), // Corrected opacity method
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: cardChild,
      ),
    );
  }

  double _getResponsiveWidth(BuildContext context) {
    if (ScreenUtil.isMobile(context)) return double.infinity;
    if (ScreenUtil.isTablet(context)) return 350;
    return 400;
  }
}
