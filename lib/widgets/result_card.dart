import 'package:flutter/material.dart';
import 'package:seeku_health_calc/utils/spacing.dart';
import 'package:seeku_health_calc/widgets/adaptive_text.dart';
import 'package:seeku_health_calc/widgets/reusable_bg_card.dart';

class ResultCard extends StatelessWidget {
  final IconData? icon;
  final Color? iconColor;
  final String title;
  final String value;
  final TextStyle? titleStyle;
  final TextStyle? valueStyle;

  const ResultCard({
    super.key,
    this.icon,
    this.iconColor,
    required this.title,
    required this.value,
    this.titleStyle,
    this.valueStyle,
  });

  @override
  Widget build(BuildContext context) {
    return ReusableBgCard(
      heightFactor: null,
      cardChild: Row(
        children: [
          if (icon != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Icon(
                icon,
                color: iconColor ?? Theme.of(context).primaryColor,
                size: 30,
              ),
            ),
          Spacing.smallHorizontal,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AdaptiveText(
                  title,
                  style: titleStyle ?? Theme.of(context).textTheme.titleMedium,
                ),
                Spacing.smallVertical,
                AdaptiveText(
                  value,
                  style: valueStyle ??
                      Theme.of(context)
                          .textTheme
                          .displayMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
