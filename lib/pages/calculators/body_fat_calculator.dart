import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seeku_health_calc/generated/l10n.dart';
import 'package:seeku_health_calc/utils/calculator_util.dart';
import 'package:seeku_health_calc/utils/providers/body_fat_result_provider.dart';
import 'package:seeku_health_calc/utils/spacing.dart';
import 'package:seeku_health_calc/widgets/adaptive_text.dart';
import 'package:seeku_health_calc/widgets/banner_ad_widget.dart';
import 'package:seeku_health_calc/widgets/counter_card.dart';
import 'package:seeku_health_calc/widgets/custom_app_bar.dart';
import 'package:seeku_health_calc/widgets/custom_elevated_button.dart';
import 'package:seeku_health_calc/widgets/gender_selector.dart';
import 'package:seeku_health_calc/widgets/input_error_dialog.dart';
import 'package:seeku_health_calc/widgets/interstitial_ad_widget.dart';
import 'package:seeku_health_calc/widgets/result_card.dart';
import 'package:seeku_health_calc/widgets/result_dialog.dart';
import 'package:seeku_health_calc/widgets/reusable_dropdown.dart';
import 'package:seeku_health_calc/widgets/slider_card.dart';
import 'package:seeku_health_calc/widgets/responsive_layout.dart';
import 'package:seeku_health_calc/widgets/reusable_bg_card.dart';

class BodyFatCalculatorScreen extends StatefulWidget {
  const BodyFatCalculatorScreen({super.key});

  @override
  BodyFatCalculatorScreenState createState() => BodyFatCalculatorScreenState();
}

class BodyFatCalculatorScreenState extends State<BodyFatCalculatorScreen> {
  final int _height = 170;
  int _weight = 70;
  int _age = 25;
  int _waistCircumference = 0;
  int _neckCircumference = 0;
  int _hipCircumference = 0;
  Gender _selectedGender = Gender.male;
  String _calculationMethod = 'bmi';

  final InterstitialAdWidget _interstitialAdWidget = InterstitialAdWidget();

  @override
  void initState() {
    super.initState();
    _interstitialAdWidget.loadInterstitialAd();
  }

  @override
  void dispose() {
    _interstitialAdWidget.dispose();
    super.dispose();
  }

  void _calculateBodyFat() {
    _interstitialAdWidget.showAd();
    try {
      // Additional validation for US Navy method
      if (_calculationMethod == 'us_navy') {
        if (_waistCircumference <= 0 || _neckCircumference <= 0) {
          _showMeasurementErrorDialog();
          return;
        }

        if (_selectedGender == Gender.female && _hipCircumference <= 0) {
          _showMeasurementErrorDialog();
          return;
        }
      }

      if (_weight > 0 &&
          _weight <= 500 &&
          _age >= 1 &&
          _age <= 120 &&
          _height > 0) {
        double bodyFatPercentage = CalculatorUtil.calculateBodyFat(
          context,
          gender: _selectedGender,
          age: _age,
          height: _height.toDouble(),
          weight: _weight.toDouble(),
          method: _calculationMethod,
          waistCircumference: _waistCircumference.toDouble(),
          neckCircumference: _neckCircumference.toDouble(),
          hipCircumference: _hipCircumference.toDouble(),
        );

        String bodyFatCategory = CalculatorUtil.getBodyFatCategory(
            context, bodyFatPercentage, _selectedGender);
        Color bodyFatCategoryColor = CalculatorUtil.getBodyFatColor(
            context, bodyFatPercentage, _selectedGender);

        Provider.of<BodyFatResultProvider>(context, listen: false).setResult(
          bodyFatPercentage: bodyFatPercentage,
          age: _age.toInt(),
          height: _height.toInt(),
          weight: _weight,
          gender: _selectedGender,
          bodyFatCategory: bodyFatCategory,
          calculationMethod: _calculationMethod,
        );

        _showResultDialog(
            bodyFatPercentage, bodyFatCategory, bodyFatCategoryColor);
      } else {
        _showInputErrorDialog();
      }
    } catch (e) {
      _showInputErrorDialog();
    }
  }

  void _showMeasurementErrorDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title:
            AdaptiveText(S.of(context).measurementRequired), // Localized title
        content: AdaptiveText(
          _calculationMethod == 'us_navy'
              ? S
                  .of(context)
                  .measurementError // Localized measurement error message
              : "Please ensure all measurements are valid.",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showResultDialog(double bodyFatPercentage, String bodyFatCategory,
      Color bodyFatCategoryColor) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ResultDialog(
          title: S.of(context).resultDialogTitle, // Localized title
          resultCards: [
            ResultCard(
              icon: Icons.fitness_center,
              title: S
                  .of(context)
                  .bodyFatPercentage, // Localized body fat percentage
              value: "${bodyFatPercentage.toStringAsFixed(1)}%",
              valueStyle: Theme.of(context).textTheme.displayLarge,
            ),
            Spacing.smallVertical,
            ResultCard(
              icon: Icons.circle,
              iconColor: bodyFatCategoryColor,
              title:
                  S.of(context).bodyFatCategory, // Localized body fat category
              value: bodyFatCategory,
              valueStyle: Theme.of(context)
                  .textTheme
                  .displayMedium
                  ?.copyWith(color: bodyFatCategoryColor),
            ),
          ],
        );
      },
    );
  }

  void _showInputErrorDialog() {
    showDialog(
      context: context,
      builder: (context) => InputErrorDialog(
        message:
            S.of(context).inputErrorMessage, // Localized input error message
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: S.of(context).appBarTitleBodyFat, // Localized title
        showBackButton: true,
      ),
      body: SingleChildScrollView(
        child: ResponsiveLayout(
          mobile: _buildMobileLayout(),
          tablet: _buildTabletLayout(),
          desktop: _buildDesktopLayout(),
        ),
      ),
      bottomNavigationBar: _buildCalculateButton(),
    );
  }

  Widget _buildCalculateButton() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        BannerAdWidget(),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
            width: double.infinity,
            child: CustomElevatedButton(
              text: S.of(context).calculateButtonText, // Localized button text
              onPressed: _calculateBodyFat,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMobileLayout() {
    return _buildContent(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
    );
  }

  Widget _buildTabletLayout() {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 800),
        child: _buildContent(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
        ),
      ),
    );
  }

  Widget _buildDesktopLayout() {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1200),
        child: _buildContent(
          padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 40),
        ),
      ),
    );
  }

  Widget _buildContent({EdgeInsets? padding}) {
    return Padding(
      padding: padding ?? EdgeInsets.all(20),
      child: Column(
        children: [
          AdaptiveText(
            S.of(context).calculateBodyFatDescription, // Localized description
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
            mobileSize: 16,
            tabletSize: 18,
            desktopSize: 20,
          ),
          Spacing.mediumVertical,
          Row(
            children: [
              Expanded(
                child: CounterCard(
                  label: S.of(context).weightLabel, // Localized weight label
                  initialValue: _weight,
                  minValue: 0,
                  maxValue: 500,
                  onChanged: (value) {
                    setState(() {
                      _weight = value;
                    });
                  },
                ),
              ),
              Spacing.mediumHorizontal,
              Expanded(
                child: CounterCard(
                  label: S.of(context).ageLabel, // Localized age label
                  initialValue: _age,
                  minValue: 1,
                  maxValue: 120,
                  onChanged: (value) {
                    setState(() {
                      _age = value;
                    });
                  },
                ),
              ),
            ],
          ),
          Spacing.mediumVertical,
          SliderCard(
            label: S
                .of(context)
                .waistCircumferenceLabel, // Localized waist circumference label
            initialValue: _waistCircumference,
            minValue: 0,
            maxValue: 300,
            onChanged: (value) {
              setState(() {
                _waistCircumference = value;
              });
            },
          ),
          Spacing.mediumVertical,
          SliderCard(
            label: S
                .of(context)
                .neckCircumferenceLabel, // Localized neck circumference label
            initialValue: _neckCircumference,
            minValue: 0,
            maxValue: 100,
            onChanged: (value) {
              setState(() {
                _neckCircumference = value;
              });
            },
          ),
          if (_selectedGender == Gender.female) ...[
            Spacing.mediumVertical,
            SliderCard(
              label: S
                  .of(context)
                  .hipCircumferenceLabel, // Localized hip circumference label
              initialValue: _hipCircumference,
              minValue: 0,
              maxValue: 300,
              onChanged: (value) {
                setState(() {
                  _hipCircumference = value;
                });
              },
            ),
          ],
          Spacing.mediumVertical,
          GenderSelector(
            initialGender: _selectedGender,
            onGenderChanged: (gender) {
              setState(() {
                _selectedGender = gender;
              });
            },
          ),
          Spacing.mediumVertical,
          ReusableBgCard(
            cardChild: Column(
              children: [
                ReusableDropdown<String>(
                  label: S
                      .of(context)
                      .calculationMethodLabel, // Localized calculation method label
                  value: _calculationMethod,
                  items: [
                    DropdownMenuItem(
                      value: 'bmi',
                      child: AdaptiveText(
                        S.of(context).bmiMethod, // Localized BMI method
                        mobileSize: 16,
                        tabletSize: 18,
                        desktopSize: 20,
                      ),
                    ),
                    DropdownMenuItem(
                      value: 'us_navy',
                      child: AdaptiveText(
                        S.of(context).usNavyMethod, // Localized US Navy method
                        mobileSize: 16,
                        tabletSize: 18,
                        desktopSize: 20,
                      ),
                    ),
                    DropdownMenuItem(
                      value: 'jackson_pollock',
                      child: AdaptiveText(
                        S
                            .of(context)
                            .jacksonPollockMethod, // Localized Jackson-Pollock method
                        mobileSize: 16,
                        tabletSize: 18,
                        desktopSize: 20,
                      ),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _calculationMethod = value!;
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
