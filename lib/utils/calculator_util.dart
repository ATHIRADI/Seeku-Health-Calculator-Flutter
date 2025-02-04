// import 'dart:math';

// import 'package:flutter/material.dart';
// import 'package:seeku_health_calc/widgets/gender_selector.dart';

// class CalculatorUtil {
//   static double calculateBMI({
//     required double weight,
//     required double height,
//     bool isMetric = true,
//   }) {
//     if (!isMetric) {
//       weight = weight * 0.453592;
//       height = height * 0.0254;
//     }

//     // Calculate BMI
//     double bmi = weight / (height * height);
//     return double.parse(bmi.toStringAsFixed(1));
//   }

//   static String getBMICategory(BuildContext context, double bmi) {
//     if (bmi < 18.5) {
//       debugPrint("Returning underweight in ${Localizations.localeOf(context)}");
//       return "Underweight";
//     }
//     if (bmi >= 18.5 && bmi < 25) {
//       debugPrint(
//           "Returning normal weight in ${Localizations.localeOf(context)}");
//       return "Normal weight";
//     }
//     if (bmi >= 25 && bmi < 30) {
//       debugPrint("Returning overweight in ${Localizations.localeOf(context)}");
//       return "Overweight";
//     }
//     debugPrint("Returning obesity in ${Localizations.localeOf(context)}");
//     return "Obesity";
//   }

//   static Color getBMICategoryColor(double bmi) {
//     if (bmi < 18.5) return Colors.blue;
//     if (bmi >= 18.5 && bmi < 25) return Colors.green;
//     if (bmi >= 25 && bmi < 30) return Colors.orange;
//     return Colors.red;
//   }

//   static String calculateHealthyWeightRange(
//       int height, int age, Gender gender) {
//     double heightInMeters = height / 100;

//     double lowerWeight = 18.5 * (heightInMeters * heightInMeters);

//     double upperWeight = 24.9 * (heightInMeters * heightInMeters);

//     return '${lowerWeight.toStringAsFixed(1)} kg - ${upperWeight.toStringAsFixed(1)} kg';
//   }

//   static double calculateIdealWeight({
//     required int height,
//     required Gender gender,
//     String method = 'robinson',
//   }) {
//     // Convert height to meters
//     double heightInMeters = height / 100.0;

//     switch (method.toLowerCase()) {
//       case 'robinson':
//         return gender == Gender.male
//             ? (52 + (1.9 * ((heightInMeters * 100 / 2.54) - 60)))
//             : (49 + (1.7 * ((heightInMeters * 100 / 2.54) - 60)));

//       case 'miller':
//         return gender == Gender.male
//             ? (56.2 + (1.41 * ((heightInMeters * 100 / 2.54) - 60)))
//             : (53.1 + (1.36 * ((heightInMeters * 100 / 2.54) - 60)));

//       case 'devine':
//         return gender == Gender.male
//             ? (50 + (2.3 * ((heightInMeters * 100 / 2.54) - 60)))
//             : (45.5 + (2.3 * ((heightInMeters * 100 / 2.54) - 60)));

//       default:
//         throw ArgumentError(
//             'Invalid method. Choose robinson, miller, or devine.');
//     }
//   }

//   static String getIdealWeightRange({
//     required int height,
//     required Gender gender,
//   }) {
//     // Calculate ideal weight using different methods
//     double robinsonWeight = calculateIdealWeight(
//         height: height, gender: gender, method: 'robinson');
//     double millerWeight =
//         calculateIdealWeight(height: height, gender: gender, method: 'miller');
//     double devineWeight =
//         calculateIdealWeight(height: height, gender: gender, method: 'devine');

//     // Calculate range with a 10% buffer
//     double lowerBound =
//         [robinsonWeight, millerWeight, devineWeight].reduce(min) * 0.9;
//     double upperBound =
//         [robinsonWeight, millerWeight, devineWeight].reduce(max) * 1.1;

//     return '${lowerBound.toStringAsFixed(1)} kg - ${upperBound.toStringAsFixed(1)} kg';
//   }

//   static double log10(double value) {
//     return log(value) / ln10;
//   }

//   static double calculateBodyFat({
//     required Gender gender,
//     required int age,
//     required double height,
//     required double weight,
//     double waistCircumference = 0.0,
//     double neckCircumference = 0.0,
//     double hipCircumference = 0.0,
//     String method = 'bmi',
//   }) {
//     switch (method.toLowerCase()) {
//       case 'bmi':
//         // BMI-based body fat estimation
//         double bmi = calculateBMI(weight: weight, height: height / 100);
//         return gender == Gender.male
//             ? (1.20 * bmi) + (0.23 * age) - 16.2
//             : (1.20 * bmi) + (0.23 * age) - 5.4;

//       case 'us_navy':
//         // US Navy Method
//         if (waistCircumference == 0.0 || neckCircumference == 0.0) {
//           throw ArgumentError(
//               'Waist and neck circumference are required for US Navy method');
//         }

//         if (gender == Gender.male) {
//           return 495 /
//                   (1.0324 -
//                       0.19077 * log10(waistCircumference - neckCircumference) +
//                       0.15456 * log10(height)) -
//               450;
//         } else {
//           if (hipCircumference == 0.0) {
//             throw ArgumentError(
//                 'Hip circumference is required for females in US Navy method');
//           }
//           return 495 /
//                   (1.29579 -
//                       0.35004 *
//                           log10(waistCircumference +
//                               hipCircumference -
//                               neckCircumference) +
//                       0.22100 * log10(height)) -
//               450;
//         }

//       case 'jackson_pollock':
//         // Jackson-Pollock 7-site method (more complex, requires multiple skinfold measurements)
//         // This is a simplified version and would need more precise skinfold measurements
//         return gender == Gender.male
//             ? (0.29288 * weight) -
//                 (0.0005 * pow(weight, 2)) +
//                 (0.15845 * age) -
//                 5.76377
//             : (0.29669 * weight) -
//                 (0.00043 * pow(weight, 2)) +
//                 (0.02963 * age) +
//                 1.4072;

//       default:
//         throw ArgumentError('Invalid body fat calculation method');
//     }
//   }

//   static String getBodyFatCategory(double bodyFatPercentage, Gender gender) {
//     if (gender == Gender.male) {
//       if (bodyFatPercentage < 6) return 'Essential Fat';
//       if (bodyFatPercentage < 14) return 'Athletes';
//       if (bodyFatPercentage < 18) return 'Fitness';
//       if (bodyFatPercentage < 25) return 'Acceptable';
//       return 'Obese';
//     } else {
//       if (bodyFatPercentage < 14) return 'Essential Fat';
//       if (bodyFatPercentage < 21) return 'Athletes';
//       if (bodyFatPercentage < 24) return 'Fitness';
//       if (bodyFatPercentage < 32) return 'Acceptable';
//       return 'Obese';
//     }
//   }

//   static Color getBodyFatColor(double bodyFatPercentage, Gender gender) {
//     String category = getBodyFatCategory(bodyFatPercentage, gender);

//     switch (category) {
//       case 'Essential Fat':
//         return Colors.green.shade200;
//       case 'Athletes':
//         return Colors.green.shade400;
//       case 'Fitness':
//         return Colors.green.shade600;
//       case 'Acceptable':
//         return Colors.orange;
//       case 'Obese':
//         return Colors.red;
//       default:
//         return Colors.grey;
//     }
//   }

//   static double calculateCalorieNeeds({
//     required int height,
//     required int weight,
//     required int age,
//     required Gender gender,
//     required String goal,
//     required double activityLevel,
//   }) {
//     // Basal Metabolic Rate (BMR) calculation using Mifflin-St Jeor Equation
//     double bmr;
//     if (gender == Gender.male) {
//       bmr = 10 * weight + 6.25 * height - 5 * age + 5;
//     } else {
//       bmr = 10 * weight + 6.25 * height - 5 * age - 161;
//     }

//     // Adjust for activity level
//     double tdee = bmr * activityLevel;

//     // Adjust for weight goal
//     switch (goal) {
//       case 'weightLoss':
//         return tdee - 500; // Create a 500 calorie deficit
//       case 'weightGain':
//         return tdee + 500; // Create a 500 calorie surplus
//       case 'maintain':
//       default:
//         return tdee;
//     }
//   }

//   static String getWeightGoalDescription(String goal) {
//     switch (goal) {
//       case 'weightLoss':
//         return 'Lose Weight (Calorie Deficit)';
//       case 'weightGain':
//         return 'Gain Weight (Calorie Surplus)';
//       case 'maintain':
//       default:
//         return 'Maintain Current Weight';
//     }
//   }

//   static int calculateMaxHeartRate(int age) {
//     // Traditional 220 - age method
//     return 220 - age;
//   }

//   static Map<String, int> calculateHeartRateZones(int maxHeartRate) {
//     return {
//       'Resting': (maxHeartRate * 0.5).round(),
//       'Fat Burning': (maxHeartRate * 0.6).round(),
//       'Cardio': (maxHeartRate * 0.7).round(),
//       'Peak': (maxHeartRate * 0.8).round(),
//       'Maximum': maxHeartRate,
//     };
//   }

//   static String getHeartRateIntensityDescription(String zone) {
//     switch (zone) {
//       case 'Resting':
//         return 'Very Light Intensity (Warm-up/Cool-down)';
//       case 'Fat Burning':
//         return 'Light Intensity (Fat Burning Zone)';
//       case 'Cardio':
//         return 'Moderate Intensity (Cardiovascular Training)';
//       case 'Peak':
//         return 'High Intensity (Performance Training)';
//       case 'Maximum':
//         return 'Maximum Effort (Short Bursts)';
//       default:
//         return 'Unknown Intensity';
//     }
//   }

//   static DateTime calculateDueDate(DateTime lastMenstrualPeriod,
//       {String method = 'naegele'}) {
//     switch (method.toLowerCase()) {
//       case 'naegele':
//         // Naegele's Rule: Add 280 days (40 weeks) to the first day of the last menstrual period
//         return lastMenstrualPeriod.add(Duration(days: 280));
//       case 'mittendorf':
//         // Mittendorf Rule: More complex calculation considering various factors
//         return lastMenstrualPeriod.add(Duration(
//           days: 288, // Slightly longer than Naegele's Rule
//         ));
//       default:
//         throw ArgumentError('Invalid due date calculation method');
//     }
//   }

//   static int calculateGestationalAge(DateTime lastMenstrualPeriod) {
//     final now = DateTime.now();
//     final difference = now.difference(lastMenstrualPeriod);

//     // Convert days to weeks and days
//     final weeks = (difference.inDays / 7).floor();
//     final days = difference.inDays % 7;

//     return weeks;
//   }

//   static String getPregnancyTrimester(int gestationalWeeks) {
//     if (gestationalWeeks < 13) {
//       return 'First Trimester';
//     } else if (gestationalWeeks < 27) {
//       return 'Second Trimester';
//     } else {
//       return 'Third Trimester';
//     }
//   }

//   static String formatDuration(DateTime startDate, DateTime endDate) {
//     final difference = endDate.difference(startDate);
//     final weeks = (difference.inDays / 7).floor();
//     final days = difference.inDays % 7;

//     return '$weeks weeks and $days days';
//   }

//   static DateTime calculateOvulationDate(DateTime lastMenstrualPeriod,
//       {int cycleDuration = 28}) {
//     // Standard calculation: Ovulation occurs around 14 days before the next period
//     return lastMenstrualPeriod.add(Duration(days: cycleDuration - 14));
//   }

//   static List<DateTime> calculateFertileWindow(DateTime lastMenstrualPeriod,
//       {int cycleDuration = 28}) {
//     // Fertile window is typically 6 days: 5 days before ovulation and the day of ovulation
//     DateTime ovulationDate = calculateOvulationDate(lastMenstrualPeriod,
//         cycleDuration: cycleDuration);

//     return [
//       ovulationDate.subtract(Duration(days: 5)),
//       ovulationDate.subtract(Duration(days: 4)),
//       ovulationDate.subtract(Duration(days: 3)),
//       ovulationDate.subtract(Duration(days: 2)),
//       ovulationDate.subtract(Duration(days: 1)),
//       ovulationDate,
//     ];
//   }

//   static String getOvulationPhaseDescription(int dayOfCycle) {
//     if (dayOfCycle < 7) return 'Menstrual Phase';
//     if (dayOfCycle < 14) return 'Follicular Phase';
//     if (dayOfCycle < 16) return 'Ovulation Phase';
//     return 'Luteal Phase';
//   }

//   static bool isDateInFertileWindow(DateTime date, DateTime lastMenstrualPeriod,
//       {int cycleDuration = 28}) {
//     List<DateTime> fertileWindow = calculateFertileWindow(lastMenstrualPeriod,
//         cycleDuration: cycleDuration);
//     return fertileWindow.any((fertileDate) => isSameDay(date, fertileDate));
//   }

//   static bool isSameDay(DateTime date1, DateTime date2) {
//     return date1.year == date2.year &&
//         date1.month == date2.month &&
//         date1.day == date2.day;
//   }

//   static double calculateBloodVolume({
//     required int weight,
//     required Gender gender,
//     String method = 'standard',
//   }) {
//     switch (method.toLowerCase()) {
//       case 'standard':
//         // Standard method:
//         // Males: 75 mL/kg
//         // Females: 65 mL/kg
//         return gender == Gender.male ? weight * 75.0 : weight * 65.0;

//       case 'detailed':
//         // More detailed calculation considering body composition
//         return gender == Gender.male
//             ? (weight * 75.0) * 1.05 // Slight adjustment for muscle mass
//             : (weight * 65.0) * 0.95; // Slight adjustment for body fat

//       default:
//         throw ArgumentError('Invalid blood volume calculation method');
//     }
//   }

//   static Map<String, dynamic> getBloodVolumeRiskFactors(double bloodVolume) {
//     return {
//       'lowRisk': bloodVolume * 0.9,
//       'highRisk': bloodVolume * 1.1,
//       'criticalLow': bloodVolume * 0.7,
//       'criticalHigh': bloodVolume * 1.3,
//     };
//   }

//   static String getBloodVolumeCategory(double bloodVolume) {
//     if (bloodVolume < 3500) return 'Low';
//     if (bloodVolume >= 3500 && bloodVolume < 5000) return 'Normal';
//     return 'High';
//   }

//   static Color getBloodVolumeColor(String category) {
//     switch (category) {
//       case 'Low':
//         return Colors.blue;
//       case 'Normal':
//         return Colors.green;
//       case 'High':
//         return Colors.orange;
//       default:
//         return Colors.grey;
//     }
//   }

//   static DateTime calculateNextDonationDate(
//       DateTime lastDonationDate, String donationType, Gender gender) {
//     switch (donationType.toLowerCase()) {
//       case 'whole_blood':
//         return lastDonationDate
//             .add(Duration(days: gender == Gender.male ? 56 : 56));
//       case 'double_red_cells':
//         return lastDonationDate.add(Duration(days: 112));
//       case 'platelet':
//         return lastDonationDate.add(Duration(days: 14));
//       case 'plasma':
//         return lastDonationDate.add(Duration(days: 28));
//       default:
//         throw ArgumentError('Invalid donation type');
//     }
//   }

//   static bool isEligibleToDonate(int age, double weight,
//       bool hasRecentMedicalConditions, bool hasTravelHistory) {
//     // Basic eligibility criteria
//     return age >= 16 &&
//         age <= 65 &&
//         weight >= 50 &&
//         !hasRecentMedicalConditions &&
//         !hasTravelHistory;
//   }

//   static String getDonationTypeDescription(String donationType) {
//     switch (donationType.toLowerCase()) {
//       case 'whole_blood':
//         return 'Whole Blood Donation (Most Common)';
//       case 'double_red_cells':
//         return 'Double Red Cells Donation';
//       case 'platelet':
//         return 'Platelet Donation';
//       case 'plasma':
//         return 'Plasma Donation';
//       default:
//         return 'Unknown Donation Type';
//     }
//   }

//   static int calculateDaysUntilNextDonation(
//       DateTime lastDonationDate, String donationType, Gender gender) {
//     DateTime nextDonationDate =
//         calculateNextDonationDate(lastDonationDate, donationType, gender);
//     return nextDonationDate.difference(DateTime.now()).inDays;
//   }

//   static double calculateBAC({
//     required double weight,
//     required Gender gender,
//     required double alcoholConsumed,
//     required double hours,
//     bool isMetric = true,
//   }) {
//     // Convert weight to pounds if not metric
//     if (!isMetric) {
//       weight = weight * 2.20462;
//     }

//     // Gender-specific metabolic rate constants
//     double genderConstant = gender == Gender.male ? 0.68 : 0.55;

//     // Calculate BAC
//     double bac = ((alcoholConsumed * 5.14) / (weight * genderConstant)) -
//         (0.015 * hours);

//     // Ensure BAC is not negative
//     return max(bac, 0.0);
//   }

//   static String getBACCategory(double bac) {
//     if (bac < 0.02) return 'Sober';
//     if (bac < 0.05) return 'Mild Impairment';
//     if (bac < 0.08) return 'Moderate Impairment';
//     if (bac < 0.15) return 'Significant Impairment';
//     if (bac < 0.30) return 'Severe Impairment';
//     return 'Potentially Fatal';
//   }

//   static Color getBACCategoryColor(double bac) {
//     if (bac < 0.02) return Colors.green;
//     if (bac < 0.05) return Colors.lightGreen;
//     if (bac < 0.08) return Colors.yellow;
//     if (bac < 0.15) return Colors.orange;
//     if (bac < 0.30) return Colors.deepOrange;
//     return Colors.red;
//   }

//   static List<Map<String, dynamic>> getEffectsAtBAC(double bac) {
//     return [
//       {
//         'bac': 0.02,
//         'effects': 'Slight mood changes, relaxation',
//         'warning': 'Some loss of judgment'
//       },
//       {
//         'bac': 0.05,
//         'effects': 'Exaggerated behavior, impaired judgment',
//         'warning': 'Reduced coordination, alertness'
//       },
//       {
//         'bac': 0.08,
//         'effects': 'Muscle coordination becomes poor',
//         'warning': 'Legal driving limit in most jurisdictions'
//       },
//       {
//         'bac': 0.15,
//         'effects': 'Balance, speech, vision severely impaired',
//         'warning': 'Significant risk of injury'
//       },
//       {
//         'bac': 0.30,
//         'effects': 'Potential loss of consciousness',
//         'warning': 'Risk of alcohol poisoning'
//       }
//     ].where((effect) => bac >= (effect['bac'] as num).toDouble()).toList();
//   }

//   static String getBloodPressureCategory(int systolic, int diastolic) {
//     if (systolic < 90 && diastolic < 60) {
//       return 'Hypotension (Low Blood Pressure)';
//     } else if ((systolic >= 90 && systolic < 120) &&
//         (diastolic >= 60 && diastolic < 80)) {
//       return 'Normal';
//     } else if ((systolic >= 120 && systolic < 130) &&
//         (diastolic >= 80 && diastolic < 85)) {
//       return 'Elevated';
//     } else if ((systolic >= 130 && systolic < 140) ||
//         (diastolic >= 85 && diastolic < 90)) {
//       return 'Hypertension Stage 1';
//     } else if (systolic >= 140 || diastolic >= 90) {
//       return 'Hypertension Stage 2';
//     } else if (systolic > 180 || diastolic > 120) {
//       return 'Hypertensive Crisis (Seek Immediate Medical Attention)';
//     }
//     return 'Unknown';
//   }

//   static Color getBloodPressureColor(BuildContext context, String category) {
//     switch (category) {
//       case 'Hypotension (Low Blood Pressure)':
//         return Theme.of(context).colorScheme.primary; // Use theme color

//       case 'Normal':
//         return Theme.of(context).colorScheme.secondary; // Use theme color

//       case 'Elevated':
//         return Colors.lightGreen;
//       case 'Hypertension Stage 1':
//         return Colors.orange;
//       case 'Hypertension Stage 2':
//         return Colors.deepOrange;
//       case 'Hypertensive Crisis (Seek Immediate Medical Attention)':
//         return Colors.red;
//       default:
//         return Colors.grey;
//     }
//   }

//   static String getBloodPressureRisk(String category) {
//     switch (category) {
//       case 'Hypotension (Low Blood Pressure)':
//         return 'Risk of dizziness, fainting, and potential organ damage';
//       case 'Normal':
//         return 'Lowest risk of heart disease and stroke';
//       case 'Elevated':
//         return 'Increased risk of developing hypertension';
//       case 'Hypertension Stage 1':
//         return 'Moderate risk of heart disease and stroke';
//       case 'Hypertension Stage 2':
//         return 'High risk of heart disease, stroke, and organ damage';
//       case 'Hypertensive Crisis (Seek Immediate Medical Attention)':
//         return 'Extremely high risk of heart attack, stroke, and organ failure';
//       default:
//         return 'Unknown risk';
//     }
//   }

//   static int calculateBreathRate(int breathCount, int durationSeconds) {
//     // Convert breath count to breaths per minute
//     return ((breathCount * 60) / durationSeconds).round();
//   }

//   static String getBreathRateCategory(int breathsPerMinute, bool isAdult) {
//     if (isAdult) {
//       if (breathsPerMinute < 12) return 'Abnormally Low';
//       if (breathsPerMinute >= 12 && breathsPerMinute <= 20) return 'Normal';
//       if (breathsPerMinute > 20 && breathsPerMinute <= 24)
//         return 'Slightly Elevated';
//       return 'Abnormally High';
//     } else {
//       // Different ranges for children
//       if (breathsPerMinute < 15) return 'Abnormally Low';
//       if (breathsPerMinute >= 15 && breathsPerMinute <= 30) return 'Normal';
//       if (breathsPerMinute > 30 && breathsPerMinute <= 40)
//         return 'Slightly Elevated';
//       return 'Abnormally High';
//     }
//   }

//   static Color getBreathRateColor(BuildContext context, String category) {
//     switch (category) {
//       case 'Abnormally Low':
//         return Theme.of(context).colorScheme.primary; // Use theme color

//       case 'Normal':
//         return Theme.of(context).colorScheme.secondary; // Use theme color

//       case 'Slightly Elevated':
//         return Colors.orange;
//       case 'Abnormally High':
//         return Colors.red;
//       default:
//         return Colors.grey;
//     }
//   }

//   static String getBreathRateDescription(String category) {
//     switch (category) {
//       case 'Abnormally Low':
//         return 'Unusually low breathing rate. Consult a healthcare professional.';
//       case 'Normal':
//         return 'Your breathing rate is within the healthy range.';
//       case 'Slightly Elevated':
//         return 'Your breathing rate is slightly higher than normal.';
//       case 'Abnormally High':
//         return 'Unusually high breathing rate. Consult a healthcare professional.';
//       default:
//         return 'Unable to determine breathing rate category.';
//     }
//   }
// }
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:seeku_health_calc/widgets/gender_selector.dart';
import 'package:seeku_health_calc/generated/l10n.dart';

class CalculatorUtil {
  static double calculateBMI({
    required double weight,
    required double height,
    bool isMetric = true,
  }) {
    if (!isMetric) {
      weight = weight * 0.453592;
      height = height * 0.0254;
    }

    // Calculate BMI
    double bmi = weight / (height * height);
    return double.parse(bmi.toStringAsFixed(1));
  }

  static String getBMICategory(BuildContext context, double bmi) {
    if (bmi < 18.5) {
      debugPrint("Returning underweight in ${Localizations.localeOf(context)}");
      return S.of(context).underweight; // Localized string
    } else if (bmi >= 18.5 && bmi < 25) {
      debugPrint(
          "Returning normal weight in ${Localizations.localeOf(context)}");
      return S.of(context).normalWeight; // Localized string
    } else if (bmi >= 25 && bmi < 30) {
      debugPrint("Returning overweight in ${Localizations.localeOf(context)}");
      return S.of(context).overweight; // Localized string
    } else {
      debugPrint("Returning obesity in ${Localizations.localeOf(context)}");
      return S.of(context).obesity; // Localized string
    }
  }

  static Color getBMICategoryColor(double bmi) {
    if (bmi < 18.5) return Colors.blue;
    if (bmi >= 18.5 && bmi < 25) return Colors.green;
    if (bmi >= 25 && bmi < 30) return Colors.orange;
    return Colors.red;
  }

  static String calculateHealthyWeightRange(
      BuildContext context, int height, int age, Gender gender) {
    double heightInMeters = height / 100.0;

    double lowerWeight = 18.5 * (heightInMeters * heightInMeters);
    double upperWeight = 24.9 * (heightInMeters * heightInMeters);

    return '${lowerWeight.toStringAsFixed(1)} kg - ${upperWeight.toStringAsFixed(1)} kg';
  }

  static double calculateIdealWeight(
    BuildContext context, {
    required int height,
    required Gender gender,
    String method = 'robinson',
  }) {
    double heightInMeters = height / 100.0;

    switch (method.toLowerCase()) {
      case 'robinson':
        return gender == Gender.male
            ? (52 + (1.9 * ((heightInMeters * 100 / 2.54) - 60)))
            : (49 + (1.7 * ((heightInMeters * 100 / 2.54) - 60)));

      case 'miller':
        return gender == Gender.male
            ? (56.2 + (1.41 * ((heightInMeters * 100 / 2.54) - 60)))
            : (53.1 + (1.36 * ((heightInMeters * 100 / 2.54) - 60)));

      case 'devine':
        return gender == Gender.male
            ? (50 + (2.3 * ((heightInMeters * 100 / 2.54) - 60)))
            : (45.5 + (2.3 * ((heightInMeters * 100 / 2.54) - 60)));

      default:
        throw ArgumentError(S.of(context).invalidMethod);
    }
  }

  static String getIdealWeightRange(
    BuildContext context, {
    required int height,
    required Gender gender,
  }) {
    double robinsonWeight = calculateIdealWeight(context,
        height: height, gender: gender, method: 'robinson');
    double millerWeight = calculateIdealWeight(context,
        height: height, gender: gender, method: 'miller');
    double devineWeight = calculateIdealWeight(context,
        height: height, gender: gender, method: 'devine');

    double lowerBound =
        [robinsonWeight, millerWeight, devineWeight].reduce(min) * 0.9;
    double upperBound =
        [robinsonWeight, millerWeight, devineWeight].reduce(max) * 1.1;

    return '${lowerBound.toStringAsFixed(1)} kg - ${upperBound.toStringAsFixed(1)} kg';
  }

  static double log10(double value) {
    return log(value) / ln10;
  }

  static double calculateBodyFat(
    BuildContext context, {
    required Gender gender,
    required int age,
    required double height,
    required double weight,
    double waistCircumference = 0.0,
    double neckCircumference = 0.0,
    double hipCircumference = 0.0,
    String method = 'bmi',
  }) {
    switch (method.toLowerCase()) {
      case 'bmi':
        double bmi = calculateBMI(weight: weight, height: height);
        return gender == Gender.male
            ? (1.20 * bmi) + (0.23 * age) - 16.2
            : (1.20 * bmi) + (0.23 * age) - 5.4;

      case 'us_navy':
        if (waistCircumference == 0.0 || neckCircumference == 0.0) {
          throw ArgumentError(S.of(context).invalidBodyFatMethod);
        }

        if (gender == Gender.male) {
          return 495 /
                  (1.0324 -
                      0.19077 * log10(waistCircumference - neckCircumference) +
                      0.15456 * log10(height)) -
              450;
        } else {
          if (hipCircumference == 0.0) {
            throw ArgumentError(S.of(context).invalidBodyFatMethod);
          }
          return 495 /
                  (1.29579 -
                      0.35004 *
                          log10(waistCircumference +
                              hipCircumference -
                              neckCircumference) +
                      0.22100 * log10(height)) -
              450;
        }

      case 'jackson_pollock':
        return gender == Gender.male
            ? (0.29288 * weight) -
                (0.0005 * pow(weight, 2)) +
                (0.15845 * age) -
                5.76377
            : (0.29669 * weight) -
                (0.00043 * pow(weight, 2)) +
                (0.02963 * age) +
                1.4072;

      default:
        throw ArgumentError(S.of(context).invalidBodyFatMethod);
    }
  }

  static String getBodyFatCategory(
      BuildContext context, double bodyFatPercentage, Gender gender) {
    if (gender == Gender.male) {
      if (bodyFatPercentage < 6) {
        return S.of(context).essentialFat;
      }
      if (bodyFatPercentage < 14) {
        return S.of(context).athletes;
      }
      if (bodyFatPercentage < 18) {
        return S.of(context).fitness;
      }
      if (bodyFatPercentage < 25) {
        return S.of(context).acceptable;
      }
      return S.of(context).obese;
    } else {
      if (bodyFatPercentage < 14) {
        return S.of(context).essentialFat;
      }
      if (bodyFatPercentage < 21) {
        return S.of(context).athletes;
      }
      if (bodyFatPercentage < 24) {
        return S.of(context).fitness;
      }
      if (bodyFatPercentage < 32) {
        return S.of(context).acceptable;
      }
      return S.of(context).obese;
    }
  }

  static Color getBodyFatColor(
      BuildContext context, double bodyFatPercentage, Gender gender) {
    String category = getBodyFatCategory(context, bodyFatPercentage, gender);
    switch (category) {
      case 'Essential Fat':
        return Colors.green.shade200;
      case 'Athletes':
        return Colors.green.shade400;
      case 'Fitness':
        return Colors.green.shade600;
      case 'Acceptable':
        return Colors.orange;
      case 'Obese':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  static double calculateCalorieNeeds({
    required int height,
    required int weight,
    required int age,
    required Gender gender,
    required String goal,
    required double activityLevel,
  }) {
    double bmr = (gender == Gender.male)
        ? (10 * weight + 6.25 * height - 5 * age + 5)
        : (10 * weight + 6.25 * height - 5 * age - 161);

    double tdee = bmr * activityLevel;

    switch (goal) {
      case 'weightLoss':
        return tdee - 500;
      case 'weightGain':
        return tdee + 500;
      case 'maintain':
      default:
        return tdee;
    }
  }

  static String getWeightGoalDescription(BuildContext context, String goal) {
    switch (goal) {
      case 'weightLoss':
        return S.of(context).weightLoss;
      case 'weightGain':
        return S.of(context).weightGain;
      case 'maintain':
      default:
        return S.of(context).maintain;
    }
  }

  static int calculateMaxHeartRate(int age) {
    return 220 - age;
  }

  static Map<String, int> calculateHeartRateZones(int maxHeartRate) {
    return {
      'Resting': (maxHeartRate * 0.5).round(),
      'Fat Burning': (maxHeartRate * 0.6).round(),
      'Cardio': (maxHeartRate * 0.7).round(),
      'Peak': (maxHeartRate * 0.8).round(),
      'Maximum': maxHeartRate,
    };
  }

  static String getHeartRateIntensityDescription(
      BuildContext context, String zone) {
    switch (zone) {
      case 'Resting':
        return S.of(context).resting;
      case 'Fat Burning':
        return S.of(context).fatBurning;
      case 'Cardio':
        return S.of(context).cardio;
      case 'Peak':
        return S.of(context).peak;
      case 'Maximum':
        return S.of(context).maximum;
      default:
        return S.of(context).unknownIntensity;
    }
  }

  static DateTime calculateDueDate(
      BuildContext context, DateTime lastMenstrualPeriod,
      {String method = 'naegele'}) {
    switch (method.toLowerCase()) {
      case 'naegele':
        return lastMenstrualPeriod.add(Duration(days: 280));
      case 'mittendorf':
        return lastMenstrualPeriod.add(Duration(days: 288));
      default:
        throw ArgumentError(S.of(context).invalidDueDateMethod);
    }
  }

  static int calculateGestationalAge(DateTime lastMenstrualPeriod) {
    final now = DateTime.now();
    final difference = now.difference(lastMenstrualPeriod);
    final weeks = (difference.inDays / 7).floor();
    // final days = difference.inDays % 7;

    return weeks;
  }

  static String getPregnancyTrimester(
      BuildContext context, int gestationalWeeks) {
    if (gestationalWeeks < 13) {
      return S.of(context).firstTrimester;
    } else if (gestationalWeeks < 27) {
      return S.of(context).secondTrimester;
    } else {
      return S.of(context).thirdTrimester;
    }
  }

  static String formatDuration(
      BuildContext context, DateTime startDate, DateTime endDate) {
    final difference = endDate.difference(startDate);
    final weeks = (difference.inDays / 7).floor();
    final days = difference.inDays % 7;

    return '$weeks ${S.of(context).weeks} and $days ${S.of(context).days}';
  }

  static DateTime calculateOvulationDate(DateTime lastMenstrualPeriod,
      {int cycleDuration = 28}) {
    return lastMenstrualPeriod.add(Duration(days: cycleDuration - 14));
  }

  static List<DateTime> calculateFertileWindow(DateTime lastMenstrualPeriod,
      {int cycleDuration = 28}) {
    DateTime ovulationDate = calculateOvulationDate(lastMenstrualPeriod,
        cycleDuration: cycleDuration);

    return [
      ovulationDate.subtract(Duration(days: 5)),
      ovulationDate.subtract(Duration(days: 4)),
      ovulationDate.subtract(Duration(days: 3)),
      ovulationDate.subtract(Duration(days: 2)),
      ovulationDate.subtract(Duration(days: 1)),
      ovulationDate,
    ];
  }

  static String getOvulationPhaseDescription(
      BuildContext context, int dayOfCycle) {
    if (dayOfCycle < 7) return S.of(context).menstrualPhase;
    if (dayOfCycle < 14) {
      return S.of(context).follicularPhase;
    }
    if (dayOfCycle < 16) {
      return S.of(context).ovulationPhase;
    }
    return S.of(context).lutealPhase;
  }

  static bool isDateInFertileWindow(
      BuildContext context, DateTime date, DateTime lastMenstrualPeriod,
      {int cycleDuration = 28}) {
    List<DateTime> fertileWindow = calculateFertileWindow(lastMenstrualPeriod,
        cycleDuration: cycleDuration);
    return fertileWindow.any((fertileDate) => isSameDay(date, fertileDate));
  }

  static bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  static double calculateBloodVolume(
    BuildContext context, {
    required int weight,
    required Gender gender,
    String method = 'standard',
  }) {
    switch (method.toLowerCase()) {
      case 'standard':
        return gender == Gender.male ? weight * 75.0 : weight * 65.0;

      case 'detailed':
        return gender == Gender.male
            ? (weight * 75.0) * 1.05
            : (weight * 65.0) * 0.95;

      default:
        throw ArgumentError(S.of(context).invalidBloodVolumeMethod);
    }
  }

  static Map<String, dynamic> getBloodVolumeRiskFactors(double bloodVolume) {
    return {
      'lowRisk': bloodVolume * 0.9,
      'highRisk': bloodVolume * 1.1,
      'criticalLow': bloodVolume * 0.7,
      'criticalHigh': bloodVolume * 1.3,
    };
  }

  static String getBloodVolumeCategory(
      BuildContext context, double bloodVolume) {
    if (bloodVolume < 3500) return S.of(context).low; // Localized string
    if (bloodVolume >= 3500 && bloodVolume < 5000) {
      return S.of(context).normal; // Localized string
    }
    return S.of(context).high; // Localized string
  }

  static Color getBloodVolumeColor(String category) {
    switch (category) {
      case 'Low':
        return Colors.blue;
      case 'Normal':
        return Colors.green;
      case 'High':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  static DateTime calculateNextDonationDate(BuildContext context,
      DateTime lastDonationDate, String donationType, Gender gender) {
    switch (donationType.toLowerCase()) {
      case 'whole_blood':
        return lastDonationDate.add(Duration(days: 56));
      case 'double_red_cells':
        return lastDonationDate.add(Duration(days: 112));
      case 'platelet':
        return lastDonationDate.add(Duration(days: 14));
      case 'plasma':
        return lastDonationDate.add(Duration(days: 28));
      default:
        throw ArgumentError(
            S.of(context).invalidDonationType); // Localized error message
    }
  }

  static bool isEligibleToDonate(int age, double weight,
      bool hasRecentMedicalConditions, bool hasTravelHistory) {
    return age >= 16 &&
        age <= 65 &&
        weight >= 50 &&
        !hasRecentMedicalConditions &&
        !hasTravelHistory;
  }

  static String getDonationTypeDescription(
      BuildContext context, String donationType) {
    switch (donationType.toLowerCase()) {
      case 'whole_blood':
        return S.of(context).wholeBlood; // Localized string
      case 'double_red_cells':
        return S.of(context).doubleRedCells; // Localized string
      case 'platelet':
        return S.of(context).platelet; // Localized string
      case 'plasma':
        return S.of(context).plasma; // Localized string
      default:
        return S.of(context).unknownDonationType; // Localized string
    }
  }

  static int calculateDaysUntilNextDonation(BuildContext context,
      DateTime lastDonationDate, String donationType, Gender gender) {
    DateTime nextDonationDate = calculateNextDonationDate(
        context, lastDonationDate, donationType, gender);
    return nextDonationDate.difference(DateTime.now()).inDays;
  }

  static double calculateBAC({
    required double weight,
    required Gender gender,
    required double alcoholConsumed,
    required double hours,
    bool isMetric = true,
  }) {
    if (!isMetric) {
      weight = weight * 2.20462; // Convert kg to pounds
    }

    double genderConstant = gender == Gender.male ? 0.68 : 0.55;

    double bac = ((alcoholConsumed * 5.14) / (weight * genderConstant)) -
        (0.015 * hours);
    return max(bac, 0.0); // Ensure BAC is not negative
  }

  static String getBACCategory(BuildContext context, double bac) {
    if (bac < 0.02) return S.of(context).sober; // Localized string
    if (bac < 0.05) return S.of(context).mildImpairment; // Localized string
    if (bac < 0.08) return S.of(context).moderateImpairment; // Localized string
    if (bac < 0.15) {
      return S.of(context).significantImpairment; // Localized string
    }
    if (bac < 0.30) return S.of(context).severeImpairment; // Localized string
    return S.of(context).potentiallyFatal; // Localized string
  }

  static Color getBACCategoryColor(double bac) {
    if (bac < 0.02) return Colors.green;
    if (bac < 0.05) return Colors.lightGreen;
    if (bac < 0.08) return Colors.yellow;
    if (bac < 0.15) return Colors.orange;
    if (bac < 0.30) return Colors.deepOrange;
    return Colors.red;
  }

  static List<Map<String, dynamic>> getEffectsAtBAC(
      BuildContext context, double bac) {
    return [
      {
        'bac': 0.02,
        'effects': S.of(context).slightMoodChanges, // Localized string
        'warning': S.of(context).someLossOfJudgment // Localized string
      },
      {
        'bac': 0.05,
        'effects': S.of(context).exaggeratedBehavior, // Localized string
        'warning': S.of(context).reducedCoordination // Localized string
      },
      {
        'bac': 0.08,
        'effects': S.of(context).muscleCoordinationPoor, // Localized string
        'warning': S.of(context).legalDrivingLimit // Localized string
      },
      {
        'bac': 0.15,
        'effects':
            S.of(context).balanceSpeechVisionImpaired, // Localized string
        'warning': S.of(context).significantRiskOfInjury // Localized string
      },
      {
        'bac': 0.30,
        'effects':
            S.of(context).potentialLossOfConsciousness, // Localized string
        'warning': S.of(context).riskOfAlcoholPoisoning // Localized string
      }
    ].where((effect) => bac >= (effect['bac'] as num).toDouble()).toList();
  }

  static String getBloodPressureCategory(
      BuildContext context, int systolic, int diastolic) {
    if (systolic < 90 && diastolic < 60) {
      return S.of(context).hypotension; // Localized string
    } else if ((systolic >= 90 && systolic < 120) &&
        (diastolic >= 60 && diastolic < 80)) {
      return S.of(context).normal; // Localized string
    } else if ((systolic >= 120 && systolic < 130) &&
        (diastolic >= 80 && diastolic < 85)) {
      return S.of(context).elevated; // Localized string
    } else if ((systolic >= 130 && systolic < 140) ||
        (diastolic >= 85 && diastolic < 90)) {
      return S.of(context).hypertensionStage1; // Localized string
    } else if (systolic >= 140 || diastolic >= 90) {
      return S.of(context).hypertensionStage2; // Localized string
    } else if (systolic > 180 || diastolic > 120) {
      return S.of(context).hypertensiveCrisis; // Localized string
    }
    return S.of(context).unknown; // Localized string
  }

  static Color getBloodPressureColor(BuildContext context, String category) {
    switch (category) {
      case 'Hypotension (Low Blood Pressure)':
        return Theme.of(context).colorScheme.primary; // Use theme color

      case 'Normal':
        return Theme.of(context).colorScheme.secondary; // Use theme color

      case 'Elevated':
        return Colors.lightGreen;
      case 'Hypertension Stage 1':
        return Colors.orange;
      case 'Hypertension Stage 2':
        return Colors.deepOrange;
      case 'Hypertensive Crisis (Seek Immediate Medical Attention)':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  static String getBloodPressureRisk(BuildContext context, String category) {
    switch (category) {
      case 'Hypotension (Low Blood Pressure)':
        return S.of(context).riskOfDizziness; // Localized string
      case 'Normal':
        return S.of(context).lowestRisk; // Localized string
      case 'Elevated':
        return S.of(context).increasedRisk; // Localized string
      case 'Hypertension Stage 1':
        return S.of(context).moderateRisk; // Localized string
      case 'Hypertension Stage 2':
        return S.of(context).highRisk; // Localized string
      case 'Hypertensive Crisis (Seek Immediate Medical Attention)':
        return S.of(context).extremelyHighRisk; // Localized string
      default:
        return S.of(context).unknownRisk; // Localized string
    }
  }

  static int calculateBreathRate(
      BuildContext context, int breathCount, int durationSeconds) {
    // Convert breath count to breaths per minute
    return ((breathCount * 60) / durationSeconds).round();
  }

  static String getBreathRateCategory(
      BuildContext context, int breathsPerMinute, bool isAdult) {
    if (isAdult) {
      if (breathsPerMinute < 12) {
        return S.of(context).abnormallyLow; // Localized string
      }
      if (breathsPerMinute >= 12 && breathsPerMinute <= 20) {
        return S.of(context).normal; // Localized string
      }
      if (breathsPerMinute > 20 && breathsPerMinute <= 24) {
        return S.of(context).slightlyElevated; // Localized string
      }
      return S.of(context).abnormallyHigh; // Localized string
    } else {
      if (breathsPerMinute < 15) {
        return S.of(context).abnormallyLow; // Localized string
      }
      if (breathsPerMinute >= 15 && breathsPerMinute <= 30) {
        return S.of(context).normal; // Localized string
      }
      if (breathsPerMinute > 30 && breathsPerMinute <= 40) {
        return S.of(context).slightlyElevated; // Localized string
      }
      return S.of(context).abnormallyHigh; // Localized string
    }
  }

  static Color getBreathRateColor(BuildContext context, String category) {
    switch (category) {
      case 'Abnormally Low':
        return Theme.of(context).colorScheme.primary; // Use theme color

      case 'Normal':
        return Theme.of(context).colorScheme.secondary; // Use theme color

      case 'Slightly Elevated':
        return Colors.orange;
      case 'Abnormally High':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  static String getBreathRateDescription(
      BuildContext context, String category) {
    switch (category) {
      case 'Abnormally Low':
        return S.of(context).unusuallyLowBreathing; // Localized string
      case 'Normal':
        return S.of(context).healthyBreathing; // Localized string
      case 'Slightly Elevated':
        return S.of(context).slightlyHigherBreathing; // Localized string
      case 'Abnormally High':
        return S.of(context).unusuallyHighBreathing; // Localized string
      default:
        return S.of(context).unknownBreathRateCategory; // Localized string
    }
  }
}
