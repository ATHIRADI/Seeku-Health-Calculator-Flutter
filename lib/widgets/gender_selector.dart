import 'package:flutter/material.dart';
import 'package:seeku_health_calc/generated/l10n.dart';
import 'package:seeku_health_calc/utils/screen_util.dart';
import 'package:seeku_health_calc/utils/spacing.dart';
import 'package:seeku_health_calc/widgets/adaptive_text.dart';
import 'package:seeku_health_calc/widgets/reusable_bg_card.dart';

enum Gender { male, female }

class GenderSelector extends StatefulWidget {
  final Gender? initialGender;
  final ValueChanged<Gender> onGenderChanged;
  final Color? activeColor;
  final Color? inactiveColor;
  final Color? backgroundColor;

  const GenderSelector({
    super.key,
    this.initialGender,
    required this.onGenderChanged,
    this.activeColor,
    this.inactiveColor,
    this.backgroundColor,
  });

  @override
  GenderSelectorState createState() => GenderSelectorState();
}

class GenderSelectorState extends State<GenderSelector> {
  late Gender? _selectedGender;

  @override
  void initState() {
    super.initState();
    _selectedGender = widget.initialGender;
  }

  @override
  Widget build(BuildContext context) {
    return ReusableBgCard(
      heightFactor: 0.20,
      color: widget.backgroundColor ?? Theme.of(context).cardColor,
      cardChild: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildTitle(),
          const SizedBox(height: 16),
          _buildGenderToggle(context),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return AdaptiveText(
      S.of(context).gender, // Localized gender label
      mobileSize: 16,
      tabletSize: 18,
      desktopSize: 20,
    );
  }

  Widget _buildGenderToggle(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildGenderButton(
          context,
          gender: Gender.male,
          icon: Icons.male,
          label: S.of(context).male, // Localized male label
        ),
        Spacing.mediumHorizontal,
        _buildGenderButton(
          context,
          gender: Gender.female,
          icon: Icons.female,
          label: S.of(context).female, // Localized female label
        ),
      ],
    );
  }

  Widget _buildGenderButton(
    BuildContext context, {
    required Gender gender,
    required IconData icon,
    required String label,
  }) {
    final isSelected = _selectedGender == gender;
    final activeColor = widget.activeColor ?? Theme.of(context).primaryColor;
    final inactiveColor =
        widget.inactiveColor ?? Theme.of(context).colorScheme.secondary;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedGender = gender;
            widget.onGenderChanged(gender);
          });
        },
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: ScreenUtil.responsiveFontSize(
              context,
              mobile: 16,
              tablet: 20,
              desktop: 24,
            ),
          ),
          decoration: BoxDecoration(
            color: isSelected ? activeColor : inactiveColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: isSelected
                    ? Theme.of(context).colorScheme.secondary
                    : Theme.of(context).colorScheme.primary,
                size: ScreenUtil.responsiveFontSize(
                  context,
                  mobile: 30,
                  tablet: 48,
                  desktop: 56,
                ),
              ),
              Spacing.smallVertical,
              AdaptiveText(
                label,
                style: TextStyle(
                  color: isSelected
                      ? Theme.of(context).colorScheme.secondary
                      : Theme.of(context).colorScheme.primary,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
                mobileSize: 20,
                tabletSize: 22,
                desktopSize: 28,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
