import 'package:flutter/material.dart';
import 'package:seeku_health_calc/utils/spacing.dart';
import 'package:seeku_health_calc/widgets/adaptive_text.dart';
import 'package:seeku_health_calc/widgets/reusable_bg_card.dart';
import 'package:seeku_health_calc/widgets/round_icon_button.dart';

class CounterCard extends StatefulWidget {
  final String label;
  final Color? backgroundColor;
  final int initialValue;
  final int minValue;
  final int maxValue;
  final ValueChanged<int>? onChanged;

  const CounterCard({
    super.key,
    required this.label,
    this.backgroundColor,
    this.initialValue = 0,
    this.minValue = 0,
    this.maxValue = 100,
    this.onChanged,
  });

  @override
  CounterCardState createState() => CounterCardState();
}

class CounterCardState extends State<CounterCard> {
  late int _currentValue;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.initialValue;
  }

  void _increment() {
    if (_currentValue < widget.maxValue) {
      setState(() {
        _currentValue++;
        widget.onChanged?.call(_currentValue);
      });
    }
  }

  void _decrement() {
    if (_currentValue > widget.minValue) {
      setState(() {
        _currentValue--;
        widget.onChanged?.call(_currentValue);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ReusableBgCard(
      heightFactor: 0.12,
      cardChild: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AdaptiveText(
            widget.label,
            mobileSize: 16,
            tabletSize: 18,
            desktopSize: 20,
          ),
          Spacing.mediumVertical,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RoundIconButton(
                icon: Icons.remove,
                onPressed: _decrement,
              ),
              Spacing.mediumHorizontal,
              AdaptiveText(
                _currentValue.toString(),
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                mobileSize: 30,
                tabletSize: 36,
                desktopSize: 40,
              ),
              Spacing.mediumHorizontal,
              RoundIconButton(
                icon: Icons.add,
                onPressed: _increment,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
