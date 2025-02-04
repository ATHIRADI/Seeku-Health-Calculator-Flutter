import 'package:flutter/material.dart';
import 'package:seeku_health_calc/utils/spacing.dart';
import 'package:seeku_health_calc/widgets/adaptive_text.dart';

class ReusableDropdown<T> extends StatelessWidget {
  final String label;
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?> onChanged;

  const ReusableDropdown({
    super.key,
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AdaptiveText(
          label,
          mobileSize: 16,
          tabletSize: 18,
          desktopSize: 20,
        ),
        Spacing.smallVertical,
        SizedBox(
          width: double.infinity,
          child: DropdownButton<T>(
            isExpanded: true,
            value: value,
            underline: Container(
              height: 2,
              color: Theme.of(context).primaryColor,
            ),
            items: items,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}
