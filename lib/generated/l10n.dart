// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name =
        (locale.countryCode?.isEmpty ?? false)
            ? locale.languageCode
            : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Seeku \nComplete Health Calculators`
  String get appTitle {
    return Intl.message(
      'Seeku \nComplete Health Calculators',
      name: 'appTitle',
      desc: '',
      args: [],
    );
  }

  /// `Get Started with Tracking Your Health!`
  String get getStartedTitle {
    return Intl.message(
      'Get Started with Tracking Your Health!',
      name: 'getStartedTitle',
      desc: '',
      args: [],
    );
  }

  /// `Calculate your Health and stay on top of your wellness journey, effortlessly.`
  String get getStartedDescription {
    return Intl.message(
      'Calculate your Health and stay on top of your wellness journey, effortlessly.',
      name: 'getStartedDescription',
      desc: '',
      args: [],
    );
  }

  /// `Get Started`
  String get getStartedButton {
    return Intl.message(
      'Get Started',
      name: 'getStartedButton',
      desc: '',
      args: [],
    );
  }

  /// `BMI Calculator`
  String get bmiCalculator {
    return Intl.message(
      'BMI Calculator',
      name: 'bmiCalculator',
      desc: '',
      args: [],
    );
  }

  /// `Ideal Weight`
  String get idealWeight {
    return Intl.message(
      'Ideal Weight',
      name: 'idealWeight',
      desc: '',
      args: [],
    );
  }

  /// `Body Fat`
  String get bodyFat {
    return Intl.message('Body Fat', name: 'bodyFat', desc: '', args: []);
  }

  /// `Calorie Needs`
  String get calorieNeeds {
    return Intl.message(
      'Calorie Needs',
      name: 'calorieNeeds',
      desc: '',
      args: [],
    );
  }

  /// `Heart Rate`
  String get heartRate {
    return Intl.message('Heart Rate', name: 'heartRate', desc: '', args: []);
  }

  /// `Pregnancy Due Date`
  String get pregnancyDueDate {
    return Intl.message(
      'Pregnancy Due Date',
      name: 'pregnancyDueDate',
      desc: '',
      args: [],
    );
  }

  /// `Ovulation Period`
  String get ovulationPeriod {
    return Intl.message(
      'Ovulation Period',
      name: 'ovulationPeriod',
      desc: '',
      args: [],
    );
  }

  /// `Blood Volume`
  String get bloodVolume {
    return Intl.message(
      'Blood Volume',
      name: 'bloodVolume',
      desc: '',
      args: [],
    );
  }

  /// `Blood Donation`
  String get bloodDonation {
    return Intl.message(
      'Blood Donation',
      name: 'bloodDonation',
      desc: '',
      args: [],
    );
  }

  /// `Blood Alcohol`
  String get bloodAlcohol {
    return Intl.message(
      'Blood Alcohol',
      name: 'bloodAlcohol',
      desc: '',
      args: [],
    );
  }

  /// `Blood Pressure`
  String get bloodPressure {
    return Intl.message(
      'Blood Pressure',
      name: 'bloodPressure',
      desc: '',
      args: [],
    );
  }

  /// `Breath Count`
  String get breathCount {
    return Intl.message(
      'Breath Count',
      name: 'breathCount',
      desc: '',
      args: [],
    );
  }

  /// `Health Calculators`
  String get appBarTitleMain {
    return Intl.message(
      'Health Calculators',
      name: 'appBarTitleMain',
      desc: '',
      args: [],
    );
  }

  /// `Seeku`
  String get drawerHeader {
    return Intl.message('Seeku', name: 'drawerHeader', desc: '', args: []);
  }

  /// `Language`
  String get language {
    return Intl.message('Language', name: 'language', desc: '', args: []);
  }

  /// `Privacy Policy`
  String get privacyPolicy {
    return Intl.message(
      'Privacy Policy',
      name: 'privacyPolicy',
      desc: '',
      args: [],
    );
  }

  /// `Share`
  String get share {
    return Intl.message('Share', name: 'share', desc: '', args: []);
  }

  /// `Rate Us`
  String get rateUs {
    return Intl.message('Rate Us', name: 'rateUs', desc: '', args: []);
  }

  /// `Feedback`
  String get feedback {
    return Intl.message('Feedback', name: 'feedback', desc: '', args: []);
  }

  /// `BMI Calculator`
  String get appBarTitleBMI {
    return Intl.message(
      'BMI Calculator',
      name: 'appBarTitleBMI',
      desc: '',
      args: [],
    );
  }

  /// `Calculate your BMI to determine the right weight for your height`
  String get calculateBMIDescription {
    return Intl.message(
      'Calculate your BMI to determine the right weight for your height',
      name: 'calculateBMIDescription',
      desc: '',
      args: [],
    );
  }

  /// `Weight (kg)`
  String get weightLabel {
    return Intl.message('Weight (kg)', name: 'weightLabel', desc: '', args: []);
  }

  /// `Age (years)`
  String get ageLabel {
    return Intl.message('Age (years)', name: 'ageLabel', desc: '', args: []);
  }

  /// `Height (cm)`
  String get heightLabel {
    return Intl.message('Height (cm)', name: 'heightLabel', desc: '', args: []);
  }

  /// `Calculate Body Fat`
  String get calculateButtonText {
    return Intl.message(
      'Calculate Body Fat',
      name: 'calculateButtonText',
      desc: '',
      args: [],
    );
  }

  /// `Your BMI Result`
  String get resultDialogTitle {
    return Intl.message(
      'Your BMI Result',
      name: 'resultDialogTitle',
      desc: '',
      args: [],
    );
  }

  /// `Healthy Weight Range`
  String get healthyWeightRange {
    return Intl.message(
      'Healthy Weight Range',
      name: 'healthyWeightRange',
      desc: '',
      args: [],
    );
  }

  /// `Please ensure all inputs are valid.`
  String get inputErrorMessage {
    return Intl.message(
      'Please ensure all inputs are valid.',
      name: 'inputErrorMessage',
      desc: '',
      args: [],
    );
  }

  /// `BMI Score`
  String get bmiScore {
    return Intl.message('BMI Score', name: 'bmiScore', desc: '', args: []);
  }

  /// `Gender`
  String get gender {
    return Intl.message('Gender', name: 'gender', desc: '', args: []);
  }

  /// `Male`
  String get male {
    return Intl.message('Male', name: 'male', desc: '', args: []);
  }

  /// `Female`
  String get female {
    return Intl.message('Female', name: 'female', desc: '', args: []);
  }

  /// `Ideal Weight Calculator`
  String get appBarTitleIdealWeight {
    return Intl.message(
      'Ideal Weight Calculator',
      name: 'appBarTitleIdealWeight',
      desc: '',
      args: [],
    );
  }

  /// `Calculate your ideal body weight based on height and gender`
  String get calculateIdealWeightDescription {
    return Intl.message(
      'Calculate your ideal body weight based on height and gender',
      name: 'calculateIdealWeightDescription',
      desc: '',
      args: [],
    );
  }

  /// `Calculation Method`
  String get calculationMethodLabel {
    return Intl.message(
      'Calculation Method',
      name: 'calculationMethodLabel',
      desc: '',
      args: [],
    );
  }

  /// `Robinson Method`
  String get robinsonMethod {
    return Intl.message(
      'Robinson Method',
      name: 'robinsonMethod',
      desc: '',
      args: [],
    );
  }

  /// `Miller Method`
  String get millerMethod {
    return Intl.message(
      'Miller Method',
      name: 'millerMethod',
      desc: '',
      args: [],
    );
  }

  /// `Devine Method`
  String get devineMethod {
    return Intl.message(
      'Devine Method',
      name: 'devineMethod',
      desc: '',
      args: [],
    );
  }

  /// `Body Fat Calculator`
  String get appBarTitleBodyFat {
    return Intl.message(
      'Body Fat Calculator',
      name: 'appBarTitleBodyFat',
      desc: '',
      args: [],
    );
  }

  /// `Measure your body fat percentage`
  String get calculateBodyFatDescription {
    return Intl.message(
      'Measure your body fat percentage',
      name: 'calculateBodyFatDescription',
      desc: '',
      args: [],
    );
  }

  /// `Waist Circumference (cm)`
  String get waistCircumferenceLabel {
    return Intl.message(
      'Waist Circumference (cm)',
      name: 'waistCircumferenceLabel',
      desc: '',
      args: [],
    );
  }

  /// `Neck Circumference (cm)`
  String get neckCircumferenceLabel {
    return Intl.message(
      'Neck Circumference (cm)',
      name: 'neckCircumferenceLabel',
      desc: '',
      args: [],
    );
  }

  /// `Hip Circumference (cm)`
  String get hipCircumferenceLabel {
    return Intl.message(
      'Hip Circumference (cm)',
      name: 'hipCircumferenceLabel',
      desc: '',
      args: [],
    );
  }

  /// `Measurement Required`
  String get measurementRequired {
    return Intl.message(
      'Measurement Required',
      name: 'measurementRequired',
      desc: '',
      args: [],
    );
  }

  /// `For US Navy method, please provide:\n- Waist Circumference\n- Neck Circumference\n- Hip Circumference`
  String get measurementError {
    return Intl.message(
      'For US Navy method, please provide:\n- Waist Circumference\n- Neck Circumference\n- Hip Circumference',
      name: 'measurementError',
      desc: '',
      args: [],
    );
  }

  /// `Body Fat Percentage`
  String get bodyFatPercentage {
    return Intl.message(
      'Body Fat Percentage',
      name: 'bodyFatPercentage',
      desc: '',
      args: [],
    );
  }

  /// `Body Fat Category`
  String get bodyFatCategory {
    return Intl.message(
      'Body Fat Category',
      name: 'bodyFatCategory',
      desc: '',
      args: [],
    );
  }

  /// `BMI-Based Method`
  String get bmiMethod {
    return Intl.message(
      'BMI-Based Method',
      name: 'bmiMethod',
      desc: '',
      args: [],
    );
  }

  /// `US Navy Method`
  String get usNavyMethod {
    return Intl.message(
      'US Navy Method',
      name: 'usNavyMethod',
      desc: '',
      args: [],
    );
  }

  /// `Jackson-Pollock Method`
  String get jacksonPollockMethod {
    return Intl.message(
      'Jackson-Pollock Method',
      name: 'jacksonPollockMethod',
      desc: '',
      args: [],
    );
  }

  /// `Calories Calculator`
  String get caloriesCalculatorTitle {
    return Intl.message(
      'Calories Calculator',
      name: 'caloriesCalculatorTitle',
      desc: '',
      args: [],
    );
  }

  /// `Calculate your daily calorie needs`
  String get caloriesCalculatorDescription {
    return Intl.message(
      'Calculate your daily calorie needs',
      name: 'caloriesCalculatorDescription',
      desc: '',
      args: [],
    );
  }

  /// `Weight Goal`
  String get weightGoalLabel {
    return Intl.message(
      'Weight Goal',
      name: 'weightGoalLabel',
      desc: '',
      args: [],
    );
  }

  /// `Activity Level`
  String get activityLevelLabel {
    return Intl.message(
      'Activity Level',
      name: 'activityLevelLabel',
      desc: '',
      args: [],
    );
  }

  /// `Calculate Calories`
  String get calculateCaloriesButton {
    return Intl.message(
      'Calculate Calories',
      name: 'calculateCaloriesButton',
      desc: '',
      args: [],
    );
  }

  /// `Your Calorie Needs`
  String get caloriesResultTitle {
    return Intl.message(
      'Your Calorie Needs',
      name: 'caloriesResultTitle',
      desc: '',
      args: [],
    );
  }

  /// `Calories Needed`
  String get caloriesResultLabel {
    return Intl.message(
      'Calories Needed',
      name: 'caloriesResultLabel',
      desc: '',
      args: [],
    );
  }

  /// `Calories/Day`
  String get caloriesPerDay {
    return Intl.message(
      'Calories/Day',
      name: 'caloriesPerDay',
      desc: '',
      args: [],
    );
  }

  /// `Maintain Weight`
  String get weightGoalMaintain {
    return Intl.message(
      'Maintain Weight',
      name: 'weightGoalMaintain',
      desc: '',
      args: [],
    );
  }

  /// `Lose Weight`
  String get weightGoalLose {
    return Intl.message(
      'Lose Weight',
      name: 'weightGoalLose',
      desc: '',
      args: [],
    );
  }

  /// `Gain Weight`
  String get weightGoalGain {
    return Intl.message(
      'Gain Weight',
      name: 'weightGoalGain',
      desc: '',
      args: [],
    );
  }

  /// `Sedentary (Little/No Exercise)`
  String get activityLevelSedentary {
    return Intl.message(
      'Sedentary (Little/No Exercise)',
      name: 'activityLevelSedentary',
      desc: '',
      args: [],
    );
  }

  /// `Lightly Active (1-3 days/week)`
  String get activityLevelLightlyActive {
    return Intl.message(
      'Lightly Active (1-3 days/week)',
      name: 'activityLevelLightlyActive',
      desc: '',
      args: [],
    );
  }

  /// `Moderately Active (3-5 days/week)`
  String get activityLevelModeratelyActive {
    return Intl.message(
      'Moderately Active (3-5 days/week)',
      name: 'activityLevelModeratelyActive',
      desc: '',
      args: [],
    );
  }

  /// `Very Active (6-7 days/week)`
  String get activityLevelVeryActive {
    return Intl.message(
      'Very Active (6-7 days/week)',
      name: 'activityLevelVeryActive',
      desc: '',
      args: [],
    );
  }

  /// `Extra Active (Hard Exercise Daily)`
  String get activityLevelExtraActive {
    return Intl.message(
      'Extra Active (Hard Exercise Daily)',
      name: 'activityLevelExtraActive',
      desc: '',
      args: [],
    );
  }

  /// `Heart Rate Calculator`
  String get heartRateCalculatorTitle {
    return Intl.message(
      'Heart Rate Calculator',
      name: 'heartRateCalculatorTitle',
      desc: '',
      args: [],
    );
  }

  /// `Calculate your heart rate training zones`
  String get heartRateCalculatorDescription {
    return Intl.message(
      'Calculate your heart rate training zones',
      name: 'heartRateCalculatorDescription',
      desc: '',
      args: [],
    );
  }

  /// `Calculate Heart Rate Zones`
  String get calculateHeartRateButton {
    return Intl.message(
      'Calculate Heart Rate Zones',
      name: 'calculateHeartRateButton',
      desc: '',
      args: [],
    );
  }

  /// `Your Heart Rate Zones`
  String get heartRateResultTitle {
    return Intl.message(
      'Your Heart Rate Zones',
      name: 'heartRateResultTitle',
      desc: '',
      args: [],
    );
  }

  /// `Heart Rate Zone Information`
  String get heartRateZoneInformationTitle {
    return Intl.message(
      'Heart Rate Zone Information',
      name: 'heartRateZoneInformationTitle',
      desc: '',
      args: [],
    );
  }

  /// `Max Heart Rate`
  String get maxHeartRateLabel {
    return Intl.message(
      'Max Heart Rate',
      name: 'maxHeartRateLabel',
      desc: '',
      args: [],
    );
  }

  /// `• Resting: Light warm-up and cool-down\n• Fat Burning: Moderate, steady-state cardio\n• Cardio: Improved cardiovascular fitness\n• Peak: High-intensity interval training\n• Maximum: Short, intense bursts of activity`
  String get heartRateZonesInfo {
    return Intl.message(
      '• Resting: Light warm-up and cool-down\n• Fat Burning: Moderate, steady-state cardio\n• Cardio: Improved cardiovascular fitness\n• Peak: High-intensity interval training\n• Maximum: Short, intense bursts of activity',
      name: 'heartRateZonesInfo',
      desc: '',
      args: [],
    );
  }

  /// `Traditional (220 - Age)`
  String get traditionalMethod {
    return Intl.message(
      'Traditional (220 - Age)',
      name: 'traditionalMethod',
      desc: '',
      args: [],
    );
  }

  /// `Pregnancy Due Date Calculator`
  String get pregnancyDueDateCalculatorTitle {
    return Intl.message(
      'Pregnancy Due Date Calculator',
      name: 'pregnancyDueDateCalculatorTitle',
      desc: '',
      args: [],
    );
  }

  /// `Calculate your estimated pregnancy due date`
  String get calculatePregnancyDueDateDescription {
    return Intl.message(
      'Calculate your estimated pregnancy due date',
      name: 'calculatePregnancyDueDateDescription',
      desc: '',
      args: [],
    );
  }

  /// `First Day of Last Menstrual Period`
  String get firstDayOfLastMenstrualPeriod {
    return Intl.message(
      'First Day of Last Menstrual Period',
      name: 'firstDayOfLastMenstrualPeriod',
      desc: '',
      args: [],
    );
  }

  /// `Select Date`
  String get selectDate {
    return Intl.message('Select Date', name: 'selectDate', desc: '', args: []);
  }

  /// `Naegele's Rule (Standard)`
  String get naegeleMethod {
    return Intl.message(
      'Naegele\'s Rule (Standard)',
      name: 'naegeleMethod',
      desc: '',
      args: [],
    );
  }

  /// `Mittendorf Rule`
  String get mittendorfMethod {
    return Intl.message(
      'Mittendorf Rule',
      name: 'mittendorfMethod',
      desc: '',
      args: [],
    );
  }

  /// `Calculate Due Date`
  String get calculateDueDateButton {
    return Intl.message(
      'Calculate Due Date',
      name: 'calculateDueDateButton',
      desc: '',
      args: [],
    );
  }

  /// `Pregnancy Due Date Results`
  String get pregnancyDueDateResultTitle {
    return Intl.message(
      'Pregnancy Due Date Results',
      name: 'pregnancyDueDateResultTitle',
      desc: '',
      args: [],
    );
  }

  /// `Estimated Due Date`
  String get estimatedDueDateLabel {
    return Intl.message(
      'Estimated Due Date',
      name: 'estimatedDueDateLabel',
      desc: '',
      args: [],
    );
  }

  /// `Gestational Age`
  String get gestationalAgeLabel {
    return Intl.message(
      'Gestational Age',
      name: 'gestationalAgeLabel',
      desc: '',
      args: [],
    );
  }

  /// `Current Trimester`
  String get currentTrimesterLabel {
    return Intl.message(
      'Current Trimester',
      name: 'currentTrimesterLabel',
      desc: '',
      args: [],
    );
  }

  /// `Pregnancy Trimester Information`
  String get pregnancyTrimesterInformationTitle {
    return Intl.message(
      'Pregnancy Trimester Information',
      name: 'pregnancyTrimesterInformationTitle',
      desc: '',
      args: [],
    );
  }

  /// `• First Trimester: Weeks 1-12\n• Second rimester: Weeks 13-26\n• Third Trimester: Weeks 27-40`
  String get pregnancyTrimesterInfo {
    return Intl.message(
      '• First Trimester: Weeks 1-12\n• Second rimester: Weeks 13-26\n• Third Trimester: Weeks 27-40',
      name: 'pregnancyTrimesterInfo',
      desc: '',
      args: [],
    );
  }

  /// `Please select the first day of your last menstrual period.`
  String get inputErrorPregnancyDate {
    return Intl.message(
      'Please select the first day of your last menstrual period.',
      name: 'inputErrorPregnancyDate',
      desc: '',
      args: [],
    );
  }

  /// `weeks`
  String get weeks {
    return Intl.message('weeks', name: 'weeks', desc: '', args: []);
  }

  /// `Ovulation Period Calculator`
  String get ovulationPeriodCalculatorTitle {
    return Intl.message(
      'Ovulation Period Calculator',
      name: 'ovulationPeriodCalculatorTitle',
      desc: '',
      args: [],
    );
  }

  /// `Calculate your ovulation and fertile window`
  String get calculateOvulationDescription {
    return Intl.message(
      'Calculate your ovulation and fertile window',
      name: 'calculateOvulationDescription',
      desc: '',
      args: [],
    );
  }

  /// `Menstrual Cycle Duration`
  String get menstrualCycleDurationLabel {
    return Intl.message(
      'Menstrual Cycle Duration',
      name: 'menstrualCycleDurationLabel',
      desc: '',
      args: [],
    );
  }

  /// `Calculate Ovulation Period`
  String get calculateOvulationButton {
    return Intl.message(
      'Calculate Ovulation Period',
      name: 'calculateOvulationButton',
      desc: '',
      args: [],
    );
  }

  /// `Ovulation Period Results`
  String get ovulationPeriodResultTitle {
    return Intl.message(
      'Ovulation Period Results',
      name: 'ovulationPeriodResultTitle',
      desc: '',
      args: [],
    );
  }

  /// `Estimated Ovulation Date`
  String get estimatedOvulationDateLabel {
    return Intl.message(
      'Estimated Ovulation Date',
      name: 'estimatedOvulationDateLabel',
      desc: '',
      args: [],
    );
  }

  /// `Fertile Window`
  String get fertileWindowLabel {
    return Intl.message(
      'Fertile Window',
      name: 'fertileWindowLabel',
      desc: '',
      args: [],
    );
  }

  /// `Menstrual Cycle Phases`
  String get menstrualCyclePhasesLabel {
    return Intl.message(
      'Menstrual Cycle Phases',
      name: 'menstrualCyclePhasesLabel',
      desc: '',
      args: [],
    );
  }

  /// `• Menstrual Phase: Days 1-6\n• Follicular Phase: Days 7-13\n• Ovulation Phase: Days 14-16\n• Luteal Phase: Days 17-28`
  String get menstrualCyclePhasesDescription {
    return Intl.message(
      '• Menstrual Phase: Days 1-6\n• Follicular Phase: Days 7-13\n• Ovulation Phase: Days 14-16\n• Luteal Phase: Days 17-28',
      name: 'menstrualCyclePhasesDescription',
      desc: '',
      args: [],
    );
  }

  /// `Please select the first day of your last menstrual period.`
  String get inputErrorOvulationDate {
    return Intl.message(
      'Please select the first day of your last menstrual period.',
      name: 'inputErrorOvulationDate',
      desc: '',
      args: [],
    );
  }

  /// `Blood Volume Calculator`
  String get bloodVolumeCalculatorTitle {
    return Intl.message(
      'Blood Volume Calculator',
      name: 'bloodVolumeCalculatorTitle',
      desc: '',
      args: [],
    );
  }

  /// `Calculate your estimated blood volume`
  String get calculateBloodVolumeDescription {
    return Intl.message(
      'Calculate your estimated blood volume',
      name: 'calculateBloodVolumeDescription',
      desc: '',
      args: [],
    );
  }

  /// `Calculate Blood Volume`
  String get calculateBloodVolumeButton {
    return Intl.message(
      'Calculate Blood Volume',
      name: 'calculateBloodVolumeButton',
      desc: '',
      args: [],
    );
  }

  /// `Blood Volume Results`
  String get bloodVolumeResultTitle {
    return Intl.message(
      'Blood Volume Results',
      name: 'bloodVolumeResultTitle',
      desc: '',
      args: [],
    );
  }

  /// `Total Blood Volume`
  String get totalBloodVolumeLabel {
    return Intl.message(
      'Total Blood Volume',
      name: 'totalBloodVolumeLabel',
      desc: '',
      args: [],
    );
  }

  /// `Blood Volume Category`
  String get bloodVolumeCategoryLabel {
    return Intl.message(
      'Blood Volume Category',
      name: 'bloodVolumeCategoryLabel',
      desc: '',
      args: [],
    );
  }

  /// `Low Risk Threshold`
  String get lowRiskThresholdLabel {
    return Intl.message(
      'Low Risk Threshold',
      name: 'lowRiskThresholdLabel',
      desc: '',
      args: [],
    );
  }

  /// `High Risk Threshold`
  String get highRiskThresholdLabel {
    return Intl.message(
      'High Risk Threshold',
      name: 'highRiskThresholdLabel',
      desc: '',
      args: [],
    );
  }

  /// `Please ensure weight is between 10 and 300 kg.`
  String get inputErrorBloodVolume {
    return Intl.message(
      'Please ensure weight is between 10 and 300 kg.',
      name: 'inputErrorBloodVolume',
      desc: '',
      args: [],
    );
  }

  /// `Standard Method`
  String get standardMethod {
    return Intl.message(
      'Standard Method',
      name: 'standardMethod',
      desc: '',
      args: [],
    );
  }

  /// `Detailed Method`
  String get detailedMethod {
    return Intl.message(
      'Detailed Method',
      name: 'detailedMethod',
      desc: '',
      args: [],
    );
  }

  /// `Blood Volume Information`
  String get bloodVolumeInformationTitle {
    return Intl.message(
      'Blood Volume Information',
      name: 'bloodVolumeInformationTitle',
      desc: '',
      args: [],
    );
  }

  /// `• Normal range: 4.5-5.5 liters\n• Varies based on body weight and gender\n• Calculated in milliliters (mL)`
  String get bloodVolumeInformationDetail {
    return Intl.message(
      '• Normal range: 4.5-5.5 liters\n• Varies based on body weight and gender\n• Calculated in milliliters (mL)',
      name: 'bloodVolumeInformationDetail',
      desc: '',
      args: [],
    );
  }

  /// `Blood Donation Calculator`
  String get bloodDonationCalculatorTitle {
    return Intl.message(
      'Blood Donation Calculator',
      name: 'bloodDonationCalculatorTitle',
      desc: '',
      args: [],
    );
  }

  /// `Calculate your next blood donation date`
  String get calculateBloodDonationDescription {
    return Intl.message(
      'Calculate your next blood donation date',
      name: 'calculateBloodDonationDescription',
      desc: '',
      args: [],
    );
  }

  /// `Last Donation Date`
  String get lastDonationDateLabel {
    return Intl.message(
      'Last Donation Date',
      name: 'lastDonationDateLabel',
      desc: '',
      args: [],
    );
  }

  /// `Donation Type`
  String get donationTypeLabel {
    return Intl.message(
      'Donation Type',
      name: 'donationTypeLabel',
      desc: '',
      args: [],
    );
  }

  /// `Calculate Donation Details`
  String get calculateDonationDetailsButton {
    return Intl.message(
      'Calculate Donation Details',
      name: 'calculateDonationDetailsButton',
      desc: '',
      args: [],
    );
  }

  /// `Blood Donation Results`
  String get bloodDonationResultTitle {
    return Intl.message(
      'Blood Donation Results',
      name: 'bloodDonationResultTitle',
      desc: '',
      args: [],
    );
  }

  /// `Next Donation Date`
  String get nextDonationDateLabel {
    return Intl.message(
      'Next Donation Date',
      name: 'nextDonationDateLabel',
      desc: '',
      args: [],
    );
  }

  /// `Days Until Next Donation`
  String get daysUntilNextDonationLabel {
    return Intl.message(
      'Days Until Next Donation',
      name: 'daysUntilNextDonationLabel',
      desc: '',
      args: [],
    );
  }

  /// `Eligibility Status`
  String get eligibilityStatusLabel {
    return Intl.message(
      'Eligibility Status',
      name: 'eligibilityStatusLabel',
      desc: '',
      args: [],
    );
  }

  /// `Recent Medical Conditions`
  String get medicalConditionsLabel {
    return Intl.message(
      'Recent Medical Conditions',
      name: 'medicalConditionsLabel',
      desc: '',
      args: [],
    );
  }

  /// `Recent Travel History`
  String get travelHistoryLabel {
    return Intl.message(
      'Recent Travel History',
      name: 'travelHistoryLabel',
      desc: '',
      args: [],
    );
  }

  /// `Whole Blood`
  String get wholeBloodDonationType {
    return Intl.message(
      'Whole Blood',
      name: 'wholeBloodDonationType',
      desc: '',
      args: [],
    );
  }

  /// `Double Red Cells`
  String get doubleRedCellsDonationType {
    return Intl.message(
      'Double Red Cells',
      name: 'doubleRedCellsDonationType',
      desc: '',
      args: [],
    );
  }

  /// `Platelet`
  String get plateletDonationType {
    return Intl.message(
      'Platelet',
      name: 'plateletDonationType',
      desc: '',
      args: [],
    );
  }

  /// `Plasma`
  String get plasmaDonationType {
    return Intl.message(
      'Plasma',
      name: 'plasmaDonationType',
      desc: '',
      args: [],
    );
  }

  /// `Eligible`
  String get eligibleStatus {
    return Intl.message('Eligible', name: 'eligibleStatus', desc: '', args: []);
  }

  /// `Not Eligible`
  String get notEligibleStatus {
    return Intl.message(
      'Not Eligible',
      name: 'notEligibleStatus',
      desc: '',
      args: [],
    );
  }

  /// `Please select your last donation date.`
  String get inputErrorLastDonationDate {
    return Intl.message(
      'Please select your last donation date.',
      name: 'inputErrorLastDonationDate',
      desc: '',
      args: [],
    );
  }

  /// `An error occurred. Please check your inputs.`
  String get inputErrorGeneral {
    return Intl.message(
      'An error occurred. Please check your inputs.',
      name: 'inputErrorGeneral',
      desc: '',
      args: [],
    );
  }

  /// `days`
  String get days {
    return Intl.message('days', name: 'days', desc: '', args: []);
  }

  /// `BAC Calculator`
  String get bacCalculatorTitle {
    return Intl.message(
      'BAC Calculator',
      name: 'bacCalculatorTitle',
      desc: '',
      args: [],
    );
  }

  /// `Calculate your Blood Alcohol Content`
  String get calculateBACDescription {
    return Intl.message(
      'Calculate your Blood Alcohol Content',
      name: 'calculateBACDescription',
      desc: '',
      args: [],
    );
  }

  /// `Gender`
  String get genderLabel {
    return Intl.message('Gender', name: 'genderLabel', desc: '', args: []);
  }

  /// `Alcohol Consumption`
  String get alcoholConsumptionTitle {
    return Intl.message(
      'Alcohol Consumption',
      name: 'alcoholConsumptionTitle',
      desc: '',
      args: [],
    );
  }

  /// `Drink Type`
  String get drinkTypeLabel {
    return Intl.message(
      'Drink Type',
      name: 'drinkTypeLabel',
      desc: '',
      args: [],
    );
  }

  /// `Drinks`
  String get drinksLabel {
    return Intl.message('Drinks', name: 'drinksLabel', desc: '', args: []);
  }

  /// `Hours Since Drinking`
  String get hoursSinceDrinkingLabel {
    return Intl.message(
      'Hours Since Drinking',
      name: 'hoursSinceDrinkingLabel',
      desc: '',
      args: [],
    );
  }

  /// `Calculate BAC`
  String get calculateBACButton {
    return Intl.message(
      'Calculate BAC',
      name: 'calculateBACButton',
      desc: '',
      args: [],
    );
  }

  /// `Blood Alcohol Content (BAC) Results`
  String get bacResultTitle {
    return Intl.message(
      'Blood Alcohol Content (BAC) Results',
      name: 'bacResultTitle',
      desc: '',
      args: [],
    );
  }

  /// `BAC Level`
  String get bacLevelLabel {
    return Intl.message('BAC Level', name: 'bacLevelLabel', desc: '', args: []);
  }

  /// `BAC Category`
  String get bacCategoryLabel {
    return Intl.message(
      'BAC Category',
      name: 'bacCategoryLabel',
      desc: '',
      args: [],
    );
  }

  /// `Important Safety Information`
  String get importantSafetyInfoTitle {
    return Intl.message(
      'Important Safety Information',
      name: 'importantSafetyInfoTitle',
      desc: '',
      args: [],
    );
  }

  /// `• Never drink and drive\n• BAC is an estimate, not a precise measurement\n• Individual metabolism varies\n• Consult local laws regarding legal BAC limits`
  String get safetyInfoText {
    return Intl.message(
      '• Never drink and drive\n• BAC is an estimate, not a precise measurement\n• Individual metabolism varies\n• Consult local laws regarding legal BAC limits',
      name: 'safetyInfoText',
      desc: '',
      args: [],
    );
  }

  /// `Beer (5% ABV)`
  String get drinkTypeBeer {
    return Intl.message(
      'Beer (5% ABV)',
      name: 'drinkTypeBeer',
      desc: '',
      args: [],
    );
  }

  /// `Wine (12% ABV)`
  String get drinkTypeWine {
    return Intl.message(
      'Wine (12% ABV)',
      name: 'drinkTypeWine',
      desc: '',
      args: [],
    );
  }

  /// `Spirits (40% ABV)`
  String get drinkTypeSpirits {
    return Intl.message(
      'Spirits (40% ABV)',
      name: 'drinkTypeSpirits',
      desc: '',
      args: [],
    );
  }

  /// `At {bac}% BAC`
  String atBACLevel(Object bac) {
    return Intl.message(
      'At $bac% BAC',
      name: 'atBACLevel',
      desc: 'Displays user BAC level, e.g. \'At 0.05% BAC\'',
      args: [bac],
    );
  }

  /// `Blood Pressure Calculator`
  String get bloodPressureCalculatorTitle {
    return Intl.message(
      'Blood Pressure Calculator',
      name: 'bloodPressureCalculatorTitle',
      desc: '',
      args: [],
    );
  }

  /// `Calculate and understand your blood pressure`
  String get calculateBloodPressureDescription {
    return Intl.message(
      'Calculate and understand your blood pressure',
      name: 'calculateBloodPressureDescription',
      desc: '',
      args: [],
    );
  }

  /// `Measurement Method`
  String get measurementMethodLabel {
    return Intl.message(
      'Measurement Method',
      name: 'measurementMethodLabel',
      desc: '',
      args: [],
    );
  }

  /// `Manual Entry`
  String get measurementMethodManual {
    return Intl.message(
      'Manual Entry',
      name: 'measurementMethodManual',
      desc: '',
      args: [],
    );
  }

  /// `Blood Pressure Device`
  String get measurementMethodDevice {
    return Intl.message(
      'Blood Pressure Device',
      name: 'measurementMethodDevice',
      desc: '',
      args: [],
    );
  }

  /// `Calculate Blood Pressure`
  String get calculateBloodPressureButton {
    return Intl.message(
      'Calculate Blood Pressure',
      name: 'calculateBloodPressureButton',
      desc: '',
      args: [],
    );
  }

  /// `Blood Pressure Reading`
  String get bloodPressureReadingTitle {
    return Intl.message(
      'Blood Pressure Reading',
      name: 'bloodPressureReadingTitle',
      desc: '',
      args: [],
    );
  }

  /// `Category`
  String get bloodPressureCategoryLabel {
    return Intl.message(
      'Category',
      name: 'bloodPressureCategoryLabel',
      desc: '',
      args: [],
    );
  }

  /// `Blood Pressure Categories`
  String get bloodPressureCategoriesTitle {
    return Intl.message(
      'Blood Pressure Categories',
      name: 'bloodPressureCategoriesTitle',
      desc: '',
      args: [],
    );
  }

  /// `Hypotension`
  String get bloodPressureCategoryHypotension {
    return Intl.message(
      'Hypotension',
      name: 'bloodPressureCategoryHypotension',
      desc: '',
      args: [],
    );
  }

  /// `Normal`
  String get bloodPressureCategoryNormal {
    return Intl.message(
      'Normal',
      name: 'bloodPressureCategoryNormal',
      desc: '',
      args: [],
    );
  }

  /// `Elevated`
  String get bloodPressureCategoryElevated {
    return Intl.message(
      'Elevated',
      name: 'bloodPressureCategoryElevated',
      desc: '',
      args: [],
    );
  }

  /// `Hypertension Stage 1`
  String get bloodPressureCategoryHypertensionStage1 {
    return Intl.message(
      'Hypertension Stage 1',
      name: 'bloodPressureCategoryHypertensionStage1',
      desc: '',
      args: [],
    );
  }

  /// `Hypertension Stage 2`
  String get bloodPressureCategoryHypertensionStage2 {
    return Intl.message(
      'Hypertension Stage 2',
      name: 'bloodPressureCategoryHypertensionStage2',
      desc: '',
      args: [],
    );
  }

  /// `Hypertensive Crisis`
  String get bloodPressureCategoryHypertensiveCrisis {
    return Intl.message(
      'Hypertensive Crisis',
      name: 'bloodPressureCategoryHypertensiveCrisis',
      desc: '',
      args: [],
    );
  }

  /// `< 90/60`
  String get bloodPressureRangeHypotension {
    return Intl.message(
      '< 90/60',
      name: 'bloodPressureRangeHypotension',
      desc: '',
      args: [],
    );
  }

  /// `90-120/60-80`
  String get bloodPressureRangeNormal {
    return Intl.message(
      '90-120/60-80',
      name: 'bloodPressureRangeNormal',
      desc: '',
      args: [],
    );
  }

  /// `120-130/80-85`
  String get bloodPressureRangeElevated {
    return Intl.message(
      '120-130/80-85',
      name: 'bloodPressureRangeElevated',
      desc: '',
      args: [],
    );
  }

  /// `130-140/85-90`
  String get bloodPressureRangeHypertensionStage1 {
    return Intl.message(
      '130-140/85-90',
      name: 'bloodPressureRangeHypertensionStage1',
      desc: '',
      args: [],
    );
  }

  /// `> 140/90`
  String get bloodPressureRangeHypertensionStage2 {
    return Intl.message(
      '> 140/90',
      name: 'bloodPressureRangeHypertensionStage2',
      desc: '',
      args: [],
    );
  }

  /// `> 180/120`
  String get bloodPressureRangeHypertensiveCrisis {
    return Intl.message(
      '> 180/120',
      name: 'bloodPressureRangeHypertensiveCrisis',
      desc: '',
      args: [],
    );
  }

  /// `Please ensure blood pressure values are within a valid range.`
  String get bloodPressureInputError {
    return Intl.message(
      'Please ensure blood pressure values are within a valid range.',
      name: 'bloodPressureInputError',
      desc: '',
      args: [],
    );
  }

  /// `Breath Count Calculator`
  String get breathCountCalculatorTitle {
    return Intl.message(
      'Breath Count Calculator',
      name: 'breathCountCalculatorTitle',
      desc: '',
      args: [],
    );
  }

  /// `Count your breaths to measure respiratory rate`
  String get breathCountDescription {
    return Intl.message(
      'Count your breaths to measure respiratory rate',
      name: 'breathCountDescription',
      desc: '',
      args: [],
    );
  }

  /// `Measurement Duration`
  String get measurementDurationLabel {
    return Intl.message(
      'Measurement Duration',
      name: 'measurementDurationLabel',
      desc: '',
      args: [],
    );
  }

  /// `Age Group`
  String get ageGroupLabel {
    return Intl.message('Age Group', name: 'ageGroupLabel', desc: '', args: []);
  }

  /// `Adult`
  String get adultLabel {
    return Intl.message('Adult', name: 'adultLabel', desc: '', args: []);
  }

  /// `Child`
  String get childLabel {
    return Intl.message('Child', name: 'childLabel', desc: '', args: []);
  }

  /// `Tap to Count Breaths`
  String get tapToCountBreathsLabel {
    return Intl.message(
      'Tap to Count Breaths',
      name: 'tapToCountBreathsLabel',
      desc: '',
      args: [],
    );
  }

  /// `Prepare to Count Breaths`
  String get prepareToCountBreathsLabel {
    return Intl.message(
      'Prepare to Count Breaths',
      name: 'prepareToCountBreathsLabel',
      desc: '',
      args: [],
    );
  }

  /// `Time Remaining`
  String get timeRemainingLabel {
    return Intl.message(
      'Time Remaining',
      name: 'timeRemainingLabel',
      desc: '',
      args: [],
    );
  }

  /// `Breaths Counted`
  String get breathsCountedLabel {
    return Intl.message(
      'Breaths Counted',
      name: 'breathsCountedLabel',
      desc: '',
      args: [],
    );
  }

  /// `Start Counting`
  String get startCountingButton {
    return Intl.message(
      'Start Counting',
      name: 'startCountingButton',
      desc: '',
      args: [],
    );
  }

  /// `Breath Count Results`
  String get breathCountResultsTitle {
    return Intl.message(
      'Breath Count Results',
      name: 'breathCountResultsTitle',
      desc: '',
      args: [],
    );
  }

  /// `Breaths per Minute`
  String get breathsPerMinuteLabel {
    return Intl.message(
      'Breaths per Minute',
      name: 'breathsPerMinuteLabel',
      desc: '',
      args: [],
    );
  }

  /// `Breath Rate Category`
  String get breathRateCategoryLabel {
    return Intl.message(
      'Breath Rate Category',
      name: 'breathRateCategoryLabel',
      desc: '',
      args: [],
    );
  }

  /// `Breath Count Guidelines`
  String get breathCountGuidelinesTitle {
    return Intl.message(
      'Breath Count Guidelines',
      name: 'breathCountGuidelinesTitle',
      desc: '',
      args: [],
    );
  }

  /// `• Sit or lie down comfortably\n• Breathe normally\n• Tap the screen for each breath\n• Accurate measurement requires calm state`
  String get breathCountGuidelinesDescription {
    return Intl.message(
      '• Sit or lie down comfortably\n• Breathe normally\n• Tap the screen for each breath\n• Accurate measurement requires calm state',
      name: 'breathCountGuidelinesDescription',
      desc: '',
      args: [],
    );
  }

  /// `Invalid Input`
  String get invalidInputTitle {
    return Intl.message(
      'Invalid Input',
      name: 'invalidInputTitle',
      desc: '',
      args: [],
    );
  }

  /// `OK`
  String get okButtonLabel {
    return Intl.message('OK', name: 'okButtonLabel', desc: '', args: []);
  }

  /// `Select Language`
  String get selectLanguageLabel {
    return Intl.message(
      'Select Language',
      name: 'selectLanguageLabel',
      desc: '',
      args: [],
    );
  }

  /// `Close`
  String get closeButtonLabel {
    return Intl.message('Close', name: 'closeButtonLabel', desc: '', args: []);
  }

  /// `Slider Value`
  String get defaultSliderLabel {
    return Intl.message(
      'Slider Value',
      name: 'defaultSliderLabel',
      desc: '',
      args: [],
    );
  }

  /// `Essential Fat`
  String get essentialFat {
    return Intl.message(
      'Essential Fat',
      name: 'essentialFat',
      desc: '',
      args: [],
    );
  }

  /// `Athletes`
  String get athletes {
    return Intl.message('Athletes', name: 'athletes', desc: '', args: []);
  }

  /// `Fitness`
  String get fitness {
    return Intl.message('Fitness', name: 'fitness', desc: '', args: []);
  }

  /// `Acceptable`
  String get acceptable {
    return Intl.message('Acceptable', name: 'acceptable', desc: '', args: []);
  }

  /// `Obese`
  String get obese {
    return Intl.message('Obese', name: 'obese', desc: '', args: []);
  }

  /// `Sober`
  String get sober {
    return Intl.message('Sober', name: 'sober', desc: '', args: []);
  }

  /// `Mild Impairment`
  String get mildImpairment {
    return Intl.message(
      'Mild Impairment',
      name: 'mildImpairment',
      desc: '',
      args: [],
    );
  }

  /// `Moderate Impairment`
  String get moderateImpairment {
    return Intl.message(
      'Moderate Impairment',
      name: 'moderateImpairment',
      desc: '',
      args: [],
    );
  }

  /// `Significant Impairment`
  String get significantImpairment {
    return Intl.message(
      'Significant Impairment',
      name: 'significantImpairment',
      desc: '',
      args: [],
    );
  }

  /// `Severe Impairment`
  String get severeImpairment {
    return Intl.message(
      'Severe Impairment',
      name: 'severeImpairment',
      desc: '',
      args: [],
    );
  }

  /// `Potentially Fatal`
  String get potentiallyFatal {
    return Intl.message(
      'Potentially Fatal',
      name: 'potentiallyFatal',
      desc: '',
      args: [],
    );
  }

  /// `Low`
  String get lowRisk {
    return Intl.message('Low', name: 'lowRisk', desc: '', args: []);
  }

  /// `Normal`
  String get normal {
    return Intl.message('Normal', name: 'normal', desc: '', args: []);
  }

  /// `High`
  String get high {
    return Intl.message('High', name: 'high', desc: '', args: []);
  }

  /// `Unknown`
  String get unknown {
    return Intl.message('Unknown', name: 'unknown', desc: '', args: []);
  }

  /// `Invalid method. Choose robinson, miller, or devine.`
  String get invalidMethod {
    return Intl.message(
      'Invalid method. Choose robinson, miller, or devine.',
      name: 'invalidMethod',
      desc: '',
      args: [],
    );
  }

  /// `Invalid body fat calculation method`
  String get invalidBodyFatMethod {
    return Intl.message(
      'Invalid body fat calculation method',
      name: 'invalidBodyFatMethod',
      desc: '',
      args: [],
    );
  }

  /// `Invalid donation type`
  String get invalidDonationType {
    return Intl.message(
      'Invalid donation type',
      name: 'invalidDonationType',
      desc: '',
      args: [],
    );
  }

  /// `Unknown Intensity`
  String get unknownIntensity {
    return Intl.message(
      'Unknown Intensity',
      name: 'unknownIntensity',
      desc: '',
      args: [],
    );
  }

  /// `Unknown risk`
  String get unknownRisk {
    return Intl.message(
      'Unknown risk',
      name: 'unknownRisk',
      desc: '',
      args: [],
    );
  }

  /// `Unable to determine breathing rate category.`
  String get unknownBreathRateCategory {
    return Intl.message(
      'Unable to determine breathing rate category.',
      name: 'unknownBreathRateCategory',
      desc: '',
      args: [],
    );
  }

  /// `Underweight`
  String get underweight {
    return Intl.message('Underweight', name: 'underweight', desc: '', args: []);
  }

  /// `Normal Weight`
  String get normalWeight {
    return Intl.message(
      'Normal Weight',
      name: 'normalWeight',
      desc: '',
      args: [],
    );
  }

  /// `Overweight`
  String get overweight {
    return Intl.message('Overweight', name: 'overweight', desc: '', args: []);
  }

  /// `Obesity`
  String get obesity {
    return Intl.message('Obesity', name: 'obesity', desc: '', args: []);
  }

  /// `Lose Weight`
  String get weightLoss {
    return Intl.message('Lose Weight', name: 'weightLoss', desc: '', args: []);
  }

  /// `Gain Weight`
  String get weightGain {
    return Intl.message('Gain Weight', name: 'weightGain', desc: '', args: []);
  }

  /// `Maintain Weight`
  String get maintain {
    return Intl.message(
      'Maintain Weight',
      name: 'maintain',
      desc: '',
      args: [],
    );
  }

  /// `Resting`
  String get resting {
    return Intl.message('Resting', name: 'resting', desc: '', args: []);
  }

  /// `Fat Burning`
  String get fatBurning {
    return Intl.message('Fat Burning', name: 'fatBurning', desc: '', args: []);
  }

  /// `Cardio`
  String get cardio {
    return Intl.message('Cardio', name: 'cardio', desc: '', args: []);
  }

  /// `Peak`
  String get peak {
    return Intl.message('Peak', name: 'peak', desc: '', args: []);
  }

  /// `Maximum`
  String get maximum {
    return Intl.message('Maximum', name: 'maximum', desc: '', args: []);
  }

  /// `Invalid due date calculation method`
  String get invalidDueDateMethod {
    return Intl.message(
      'Invalid due date calculation method',
      name: 'invalidDueDateMethod',
      desc: '',
      args: [],
    );
  }

  /// `First Trimester`
  String get firstTrimester {
    return Intl.message(
      'First Trimester',
      name: 'firstTrimester',
      desc: '',
      args: [],
    );
  }

  /// `Second Trimester`
  String get secondTrimester {
    return Intl.message(
      'Second Trimester',
      name: 'secondTrimester',
      desc: '',
      args: [],
    );
  }

  /// `Third Trimester`
  String get thirdTrimester {
    return Intl.message(
      'Third Trimester',
      name: 'thirdTrimester',
      desc: '',
      args: [],
    );
  }

  /// `Menstrual Phase`
  String get menstrualPhase {
    return Intl.message(
      'Menstrual Phase',
      name: 'menstrualPhase',
      desc: '',
      args: [],
    );
  }

  /// `Luteal Phase`
  String get lutealPhase {
    return Intl.message(
      'Luteal Phase',
      name: 'lutealPhase',
      desc: '',
      args: [],
    );
  }

  /// `Follicular Phase`
  String get follicularPhase {
    return Intl.message(
      'Follicular Phase',
      name: 'follicularPhase',
      desc: '',
      args: [],
    );
  }

  /// `Ovulation Phase`
  String get ovulationPhase {
    return Intl.message(
      'Ovulation Phase',
      name: 'ovulationPhase',
      desc: '',
      args: [],
    );
  }

  /// `Invalid blood volume calculation method`
  String get invalidBloodVolumeMethod {
    return Intl.message(
      'Invalid blood volume calculation method',
      name: 'invalidBloodVolumeMethod',
      desc: '',
      args: [],
    );
  }

  /// `Low`
  String get low {
    return Intl.message('Low', name: 'low', desc: '', args: []);
  }

  /// `Whole Blood`
  String get wholeBlood {
    return Intl.message('Whole Blood', name: 'wholeBlood', desc: '', args: []);
  }

  /// `Double Red Cells`
  String get doubleRedCells {
    return Intl.message(
      'Double Red Cells',
      name: 'doubleRedCells',
      desc: '',
      args: [],
    );
  }

  /// `Platelet`
  String get platelet {
    return Intl.message('Platelet', name: 'platelet', desc: '', args: []);
  }

  /// `Plasma`
  String get plasma {
    return Intl.message('Plasma', name: 'plasma', desc: '', args: []);
  }

  /// `Unknown Donation Type`
  String get unknownDonationType {
    return Intl.message(
      'Unknown Donation Type',
      name: 'unknownDonationType',
      desc: '',
      args: [],
    );
  }

  /// `Slight mood changes, relaxation`
  String get slightMoodChanges {
    return Intl.message(
      'Slight mood changes, relaxation',
      name: 'slightMoodChanges',
      desc: '',
      args: [],
    );
  }

  /// `Some loss of judgment`
  String get someLossOfJudgment {
    return Intl.message(
      'Some loss of judgment',
      name: 'someLossOfJudgment',
      desc: '',
      args: [],
    );
  }

  /// `Exaggerated behavior, impaired judgment`
  String get exaggeratedBehavior {
    return Intl.message(
      'Exaggerated behavior, impaired judgment',
      name: 'exaggeratedBehavior',
      desc: '',
      args: [],
    );
  }

  /// `Reduced coordination, alertness`
  String get reducedCoordination {
    return Intl.message(
      'Reduced coordination, alertness',
      name: 'reducedCoordination',
      desc: '',
      args: [],
    );
  }

  /// `Muscle coordination becomes poor`
  String get muscleCoordinationPoor {
    return Intl.message(
      'Muscle coordination becomes poor',
      name: 'muscleCoordinationPoor',
      desc: '',
      args: [],
    );
  }

  /// `Legal driving limit in most jurisdictions`
  String get legalDrivingLimit {
    return Intl.message(
      'Legal driving limit in most jurisdictions',
      name: 'legalDrivingLimit',
      desc: '',
      args: [],
    );
  }

  /// `Balance, speech, vision severely impaired`
  String get balanceSpeechVisionImpaired {
    return Intl.message(
      'Balance, speech, vision severely impaired',
      name: 'balanceSpeechVisionImpaired',
      desc: '',
      args: [],
    );
  }

  /// `Potential loss of consciousness`
  String get potentialLossOfConsciousness {
    return Intl.message(
      'Potential loss of consciousness',
      name: 'potentialLossOfConsciousness',
      desc: '',
      args: [],
    );
  }

  /// `Risk of alcohol poisoning`
  String get riskOfAlcoholPoisoning {
    return Intl.message(
      'Risk of alcohol poisoning',
      name: 'riskOfAlcoholPoisoning',
      desc: '',
      args: [],
    );
  }

  /// `Hypotension`
  String get hypotension {
    return Intl.message('Hypotension', name: 'hypotension', desc: '', args: []);
  }

  /// `Elevated`
  String get elevated {
    return Intl.message('Elevated', name: 'elevated', desc: '', args: []);
  }

  /// `Hypertension Stage 1`
  String get hypertensionStage1 {
    return Intl.message(
      'Hypertension Stage 1',
      name: 'hypertensionStage1',
      desc: '',
      args: [],
    );
  }

  /// `Hypertension Stage 2`
  String get hypertensionStage2 {
    return Intl.message(
      'Hypertension Stage 2',
      name: 'hypertensionStage2',
      desc: '',
      args: [],
    );
  }

  /// `Hypertensive Crisis`
  String get hypertensiveCrisis {
    return Intl.message(
      'Hypertensive Crisis',
      name: 'hypertensiveCrisis',
      desc: '',
      args: [],
    );
  }

  /// `Risk of dizziness, fainting, and potential organ damage`
  String get riskOfDizziness {
    return Intl.message(
      'Risk of dizziness, fainting, and potential organ damage',
      name: 'riskOfDizziness',
      desc: '',
      args: [],
    );
  }

  /// `Lowest risk of heart disease and stroke`
  String get lowestRisk {
    return Intl.message(
      'Lowest risk of heart disease and stroke',
      name: 'lowestRisk',
      desc: '',
      args: [],
    );
  }

  /// `Increased risk of developing hypertension`
  String get increasedRisk {
    return Intl.message(
      'Increased risk of developing hypertension',
      name: 'increasedRisk',
      desc: '',
      args: [],
    );
  }

  /// `Moderate risk of heart disease and stroke`
  String get moderateRisk {
    return Intl.message(
      'Moderate risk of heart disease and stroke',
      name: 'moderateRisk',
      desc: '',
      args: [],
    );
  }

  /// `High risk of heart disease, stroke, and organ damage`
  String get highRisk {
    return Intl.message(
      'High risk of heart disease, stroke, and organ damage',
      name: 'highRisk',
      desc: '',
      args: [],
    );
  }

  /// `Extremely high risk of heart attack, stroke, and organ failure`
  String get extremelyHighRisk {
    return Intl.message(
      'Extremely high risk of heart attack, stroke, and organ failure',
      name: 'extremelyHighRisk',
      desc: '',
      args: [],
    );
  }

  /// `Abnormally Low`
  String get abnormallyLow {
    return Intl.message(
      'Abnormally Low',
      name: 'abnormallyLow',
      desc: '',
      args: [],
    );
  }

  /// `Slightly Elevated`
  String get slightlyElevated {
    return Intl.message(
      'Slightly Elevated',
      name: 'slightlyElevated',
      desc: '',
      args: [],
    );
  }

  /// `Abnormally High`
  String get abnormallyHigh {
    return Intl.message(
      'Abnormally High',
      name: 'abnormallyHigh',
      desc: '',
      args: [],
    );
  }

  /// `Unusually low breathing rate. Consult a healthcare professional.`
  String get unusuallyLowBreathing {
    return Intl.message(
      'Unusually low breathing rate. Consult a healthcare professional.',
      name: 'unusuallyLowBreathing',
      desc: '',
      args: [],
    );
  }

  /// `Your breathing rate is within the healthy range.`
  String get healthyBreathing {
    return Intl.message(
      'Your breathing rate is within the healthy range.',
      name: 'healthyBreathing',
      desc: '',
      args: [],
    );
  }

  /// `Your breathing rate is slightly higher than normal.`
  String get slightlyHigherBreathing {
    return Intl.message(
      'Your breathing rate is slightly higher than normal.',
      name: 'slightlyHigherBreathing',
      desc: '',
      args: [],
    );
  }

  /// `Unusually high breathing rate. Consult a healthcare professional.`
  String get unusuallyHighBreathing {
    return Intl.message(
      'Unusually high breathing rate. Consult a healthcare professional.',
      name: 'unusuallyHighBreathing',
      desc: '',
      args: [],
    );
  }

  /// `Significant risk of injury`
  String get significantRiskOfInjury {
    return Intl.message(
      'Significant risk of injury',
      name: 'significantRiskOfInjury',
      desc: '',
      args: [],
    );
  }

  /// `Dark Mode`
  String get darkMode {
    return Intl.message('Dark Mode', name: 'darkMode', desc: '', args: []);
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
      Locale.fromSubtags(languageCode: 'de'),
      Locale.fromSubtags(languageCode: 'es'),
      Locale.fromSubtags(languageCode: 'fr'),
      Locale.fromSubtags(languageCode: 'hi'),
      Locale.fromSubtags(languageCode: 'ja'),
      Locale.fromSubtags(languageCode: 'ko'),
      Locale.fromSubtags(languageCode: 'pt'),
      Locale.fromSubtags(languageCode: 'ru'),
      Locale.fromSubtags(languageCode: 'zh'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
