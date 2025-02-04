import 'package:flutter/material.dart';
import 'package:seeku_health_calc/utils/screen_util.dart';
import 'package:seeku_health_calc/utils/spacing.dart';
import 'package:seeku_health_calc/widgets/adaptive_text.dart';
// Import localization
import 'package:seeku_health_calc/generated/l10n.dart';

class SliderCard extends StatefulWidget {
  final int initialValue;
  final int minValue;
  final int maxValue;
  final Function(int)? onChanged;
  final Color? activeColor;
  final Color? inactiveColor;
  final String? label;

  const SliderCard({
    super.key,
    required this.initialValue,
    this.minValue = 15,
    this.maxValue = 60,
    this.onChanged,
    this.activeColor,
    this.inactiveColor,
    this.label,
  });

  @override
  SliderCardState createState() => SliderCardState();
}

class SliderCardState extends State<SliderCard> {
  late double _currentValue;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.initialValue.toDouble();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(15),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: ScreenUtil.responsivePadding(context).horizontal / 1.5,
        vertical: ScreenUtil.responsivePadding(context).vertical / 2,
      ),
      child: Column(
        children: [
          _buildTitle(),
          Spacing.smallVertical,
          Row(
            children: [
              _buildSliderDisplay(),
              Spacing.smallHorizontal,
              _buildSlider(context),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    // Use the localized defaultSliderLabel if widget.label is null
    return AdaptiveText(
      widget.label ?? S.of(context).defaultSliderLabel,
      mobileSize: 16,
      tabletSize: 18,
      desktopSize: 20,
    );
  }

  Widget _buildSliderDisplay() {
    return AdaptiveText(
      '${_currentValue.round()}',
      style: Theme.of(context).textTheme.displayMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
      mobileSize: 30,
      tabletSize: 36,
      desktopSize: 40,
    );
  }

  Widget _buildSlider(BuildContext context) {
    return SliderTheme(
      data: SliderThemeData(
        activeTrackColor:
            widget.activeColor ?? Theme.of(context).colorScheme.secondary,
        inactiveTrackColor:
            widget.inactiveColor ?? Theme.of(context).primaryColor,
        thumbColor:
            widget.activeColor ?? Theme.of(context).colorScheme.secondary,
        overlayColor: (widget.activeColor ?? Theme.of(context).primaryColor)
            .withOpacity(0.2),
        thumbShape: RoundSliderThumbShape(
          enabledThumbRadius: _getResponsiveThumbRadius(context),
        ),
        overlayShape: RoundSliderOverlayShape(
          overlayRadius: _getResponsiveThumbRadius(context) * 2,
        ),
      ),
      child: Expanded(
        child: Slider(
          value: _currentValue,
          min: widget.minValue.toDouble(),
          max: widget.maxValue.toDouble(),
          onChanged: widget.onChanged == null
              ? null
              : (double newValue) {
                  setState(() {
                    _currentValue = newValue;
                  });
                  widget.onChanged!(newValue.round());
                },
          divisions: widget.maxValue - widget.minValue,
          label: '${_currentValue.round()}',
        ),
      ),
    );
  }

  double _getResponsiveThumbRadius(BuildContext context) {
    return ScreenUtil.responsiveFontSize(
      context,
      mobile: 10,
      tablet: 12,
      desktop: 14,
    );
  }
}
