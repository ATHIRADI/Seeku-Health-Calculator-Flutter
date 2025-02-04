import 'package:flutter/material.dart';
import 'package:seeku_health_calc/pages/base_screen.dart';
import 'package:seeku_health_calc/pages/calculators/blood_pressure_calculator.dart';
import 'package:seeku_health_calc/pages/calculators/bmi_calculator.dart';
import 'package:seeku_health_calc/pages/calculators/body_fat_calculator.dart';
import 'package:seeku_health_calc/pages/calculators/bac_calculator.dart';
import 'package:seeku_health_calc/pages/calculators/blood_donation_calculator.dart';
import 'package:seeku_health_calc/pages/calculators/blood_volume_calculator.dart';
import 'package:seeku_health_calc/pages/calculators/breath_count_calculator.dart';
import 'package:seeku_health_calc/pages/calculators/heart_rate_calculator.dart';
import 'package:seeku_health_calc/pages/calculators/ovulation_period_calculator.dart';
import 'package:seeku_health_calc/pages/calculators/pregnancy_due_date_calculator.dart';
import 'package:seeku_health_calc/pages/calculators/calories_calculator.dart';
import 'package:seeku_health_calc/pages/calculators/ideal_weight_calculator.dart';
import 'package:seeku_health_calc/pages/intro_screen.dart';

class AppRoutes {
  static const String intro = '/';
  static const String home = '/home';
  static const String bmiCalculator = '/bmi_calculator';
  static const String idealWeightCalculator = '/ideal_weight_calculator';
  static const String bodyFatCalculator = '/body_fat_calculator';
  static const String caloriesCalculator = '/calories_calculator';
  static const String heartRateCalculator = '/heart_rate_calculator';
  static const String pregnancyDueDateCalculator =
      '/pregnancy_due_date_calculator';
  static const String ovulationPeriodCalculator =
      '/ovulation_period_date_calculator';
  static const String bloodVolumeCalculator = '/blood_volume_calculator';
  static const String bloodDonationCalculator = '/blood_donation_calculator';
  static const String bacCalculator = '/bac_calculator';
  static const String breathCountResultCalculator =
      '/breath_count_result_calculator';
  static const String bloodPressureCalculator = '/blood_pressure_calculator';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case intro:
        return MaterialPageRoute(builder: (_) => const IntroScreen());
      case home:
        return MaterialPageRoute(builder: (_) => BaseScreen());

      case bmiCalculator:
        return MaterialPageRoute(builder: (_) => const BMICalculatorScreen());
      case idealWeightCalculator:
        return MaterialPageRoute(
            builder: (_) => const IdealWeightCalculatorScreen());
      case bodyFatCalculator:
        return MaterialPageRoute(
            builder: (_) => const BodyFatCalculatorScreen());
      case caloriesCalculator:
        return MaterialPageRoute(
            builder: (_) => const CaloriesCalculatorScreen());
      case heartRateCalculator:
        return MaterialPageRoute(
            builder: (_) => const HeartRateCalculatorScreen());
      case pregnancyDueDateCalculator:
        return MaterialPageRoute(
            builder: (_) => const PregnancyDueDateCalculatorScreen());
      case ovulationPeriodCalculator:
        return MaterialPageRoute(
            builder: (_) => const OvulationPeriodCalculatorScreen());
      case bloodVolumeCalculator:
        return MaterialPageRoute(
            builder: (_) => const BloodVolumeCalculatorScreen());
      case bloodDonationCalculator:
        return MaterialPageRoute(
            builder: (_) => const BloodDonationCalculatorScreen());
      case bacCalculator:
        return MaterialPageRoute(builder: (_) => const BACCalculatorScreen());
      case breathCountResultCalculator:
        return MaterialPageRoute(
            builder: (_) => const BreathCountCalculatorScreen());
      case bloodPressureCalculator:
        return MaterialPageRoute(
            builder: (_) => const BloodPressureCalculatorScreen());

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
