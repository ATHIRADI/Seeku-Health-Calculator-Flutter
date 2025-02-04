import 'package:flutter/material.dart';
import 'package:seeku_health_calc/utils/screen_util.dart';
import 'package:seeku_health_calc/widgets/adaptive_text.dart';
import 'package:seeku_health_calc/widgets/reusable_bg_card.dart';

class SettingsOption extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const SettingsOption({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ReusableBgCard(
      onTap: onTap,
      cardChild: Row(
        children: [
          Icon(
            icon,
            color: Theme.of(context).iconTheme.color,
            size: ScreenUtil.responsiveFontSize(
              context,
              mobile: 28,
              tablet: 38,
              desktop: 48,
            ),
          ),
          const SizedBox(width: 16),
          AdaptiveText(
            title,
            style: Theme.of(context).textTheme.bodyLarge,
            mobileSize: 14,
            tabletSize: 18,
            desktopSize: 20,
          ),
          Spacer(),
          Icon(
            Icons.arrow_forward,
            color: Theme.of(context).iconTheme.color,
            size: ScreenUtil.responsiveFontSize(
              context,
              mobile: 18,
              tablet: 28,
              desktop: 38,
            ),
          ),
        ],
      ),
    );
  }
}
