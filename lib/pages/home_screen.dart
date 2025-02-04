import 'package:flutter/material.dart';
import 'package:seeku_health_calc/generated/l10n.dart';
import 'package:seeku_health_calc/utils/routes/app_routes.dart';
import 'package:seeku_health_calc/utils/screen_util.dart';
import 'package:seeku_health_calc/utils/spacing.dart';
import 'package:seeku_health_calc/widgets/adaptive_text.dart';
import 'package:seeku_health_calc/widgets/responsive_layout.dart';
import 'package:seeku_health_calc/widgets/reusable_bg_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localization = S.of(context);

    return Scaffold(
      body: ResponsiveLayout(
        mobile: _buildMobileLayout(context, localization),
        tablet: _buildTabletLayout(context, localization),
        desktop: _buildDesktopLayout(context, localization),
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context, localization) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        child: _buildContent(context, localization),
      ),
    );
  }

  Widget _buildTabletLayout(BuildContext context, localization) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
        child: _buildContent(context, localization),
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context, localization) {
    return SafeArea(
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 80),
            child: _buildContent(context, localization),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, localization) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildCalculatorGrid(context, localization),
      ],
    );
  }

  Widget _buildCalculatorGrid(BuildContext context, localization) {
    return GridView.count(
      crossAxisCount: ScreenUtil.isTablet(context) ? 3 : 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      children: [
        _buildCalculatorCard(
          context,
          icon: Icons.calculate_outlined,
          title: localization.bmiCalculator, // Localized title
          onTap: () => Navigator.pushNamed(context, AppRoutes.bmiCalculator),
        ),
        _buildCalculatorCard(
          context,
          icon: Icons.line_weight,
          title: localization.idealWeight, // Localized title
          onTap: () =>
              Navigator.pushNamed(context, AppRoutes.idealWeightCalculator),
        ),
        _buildCalculatorCard(
          context,
          icon: Icons.percent,
          title: localization.bodyFat, // Localized title
          onTap: () =>
              Navigator.pushNamed(context, AppRoutes.bodyFatCalculator),
        ),
        _buildCalculatorCard(
          context,
          icon: Icons.local_dining,
          title: localization.calorieNeeds, // Localized title
          onTap: () =>
              Navigator.pushNamed(context, AppRoutes.caloriesCalculator),
        ),
        _buildCalculatorCard(
          context,
          icon: Icons.favorite_border,
          title: localization.heartRate, // Localized title
          onTap: () =>
              Navigator.pushNamed(context, AppRoutes.heartRateCalculator),
        ),
        _buildCalculatorCard(
          context,
          icon: Icons.pregnant_woman,
          title: localization.pregnancyDueDate, // Localized title
          onTap: () => Navigator.pushNamed(
              context, AppRoutes.pregnancyDueDateCalculator),
        ),
        _buildCalculatorCard(
          context,
          icon: Icons.calendar_today,
          title: localization.ovulationPeriod, // Localized title
          onTap: () =>
              Navigator.pushNamed(context, AppRoutes.ovulationPeriodCalculator),
        ),
        _buildCalculatorCard(
          context,
          icon: Icons.water_drop_outlined,
          title: localization.bloodVolume, // Localized title
          onTap: () =>
              Navigator.pushNamed(context, AppRoutes.bloodVolumeCalculator),
        ),
        _buildCalculatorCard(
          context,
          icon: Icons.bloodtype,
          title: localization.bloodDonation, // Localized title
          onTap: () =>
              Navigator.pushNamed(context, AppRoutes.bloodDonationCalculator),
        ),
        _buildCalculatorCard(
          context,
          icon: Icons.local_drink,
          title: localization.bloodAlcohol, // Localized title
          onTap: () => Navigator.pushNamed(context, AppRoutes.bacCalculator),
        ),
        _buildCalculatorCard(
          context,
          icon: Icons.monitor_heart_outlined,
          title: localization.bloodPressure, // Localized title
          onTap: () =>
              Navigator.pushNamed(context, AppRoutes.bloodPressureCalculator),
        ),
        _buildCalculatorCard(
          context,
          icon: Icons.air,
          title: localization.breathCount, // Localized title
          onTap: () => Navigator.pushNamed(
              context, AppRoutes.breathCountResultCalculator),
        ),
      ],
    );
  }

  Widget _buildCalculatorCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ReusableBgCard(
      onTap: onTap,
      cardChild: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 48,
            color: Theme.of(context).primaryColor,
          ),
          Spacing.mediumVertical,
          AdaptiveText(
            title,
            style: Theme.of(context).textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
