import 'package:flutter/material.dart';
import 'package:seeku_health_calc/utils/screen_util.dart';

class RoundIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? iconColor;

  const RoundIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.backgroundColor,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor ?? Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(15),
          onTap: onPressed,
          child: Container(
            width: _getResponsiveSize(context),
            height: _getResponsiveSize(context),
            alignment: Alignment.center,
            child: Icon(
              icon,
              color: iconColor ?? Theme.of(context).colorScheme.primary,
              size: _getIconSize(context),
            ),
          ),
        ),
      ),
    );
  }

  double _getResponsiveSize(BuildContext context) {
    return ScreenUtil.responsiveFontSize(
      context,
      mobile: 30,
      tablet: 48,
      desktop: 54,
    );
  }

  double _getIconSize(BuildContext context) {
    return ScreenUtil.responsiveFontSize(
      context,
      mobile: 20,
      tablet: 28,
      desktop: 32,
    );
  }
}
