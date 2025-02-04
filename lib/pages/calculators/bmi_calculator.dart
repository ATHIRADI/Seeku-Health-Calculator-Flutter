import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seeku_health_calc/generated/l10n.dart';
import 'package:seeku_health_calc/utils/calculator_util.dart';
import 'package:seeku_health_calc/utils/providers/bmi_result_provider.dart';
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
import 'package:seeku_health_calc/widgets/slider_card.dart';
import 'package:seeku_health_calc/widgets/responsive_layout.dart';

class BMICalculatorScreen extends StatefulWidget {
  const BMICalculatorScreen({super.key});

  @override
  BMICalculatorScreenState createState() => BMICalculatorScreenState();
}

class BMICalculatorScreenState extends State<BMICalculatorScreen> {
  int _height = 170;
  int _weight = 70;
  int _age = 25;
  Gender _selectedGender = Gender.male;

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

  void _calculateBMI() {
    _interstitialAdWidget.showAd();
    if (_weight > 0 &&
        _weight <= 500 &&
        _age >= 1 &&
        _age <= 120 &&
        _height > 0) {
      double heightInMeters = _height / 100;
      double bmiResult = CalculatorUtil.calculateBMI(
        weight: _weight.toDouble(),
        height: heightInMeters,
      );

      String bmiCategory = CalculatorUtil.getBMICategory(context, bmiResult);
      Color bmiCategoryColor = CalculatorUtil.getBMICategoryColor(bmiResult);

      // Set the result in the BMIResultProvider
      Provider.of<BMIResultProvider>(context, listen: false).setResult(
        bmiResult: bmiResult,
        weight: _weight,
        height: _height,
        age: _age,
        gender: _selectedGender,
        bmiCategory: bmiCategory,
      );

      _showResultDialog(bmiResult, bmiCategory, bmiCategoryColor);
    } else {
      _showInputErrorDialog();
    }
  }

  void _showResultDialog(
      double bmiResult, String bmiCategory, Color bmiCategoryColor) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ResultDialog(
          title: S.of(context).resultDialogTitle, // Localized title
          resultCards: [
            ResultCard(
              icon: Icons.health_and_safety,
              iconColor: bmiCategoryColor,
              title: S.of(context).bmiScore,
              value: bmiResult.toStringAsFixed(1),
              valueStyle: Theme.of(context)
                  .textTheme
                  .displayLarge!
                  .copyWith(color: bmiCategoryColor),
            ),
            Spacing.smallVertical,
            ResultCard(
              icon: Icons.circle,
              iconColor: bmiCategoryColor,
              title: S.of(context).healthyWeightRange, // Localized title
              value: Provider.of<BMIResultProvider>(context, listen: false)
                      .healthyWeightRange(context) ??
                  '',
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
        message: S.of(context).inputErrorMessage, // Localized error message
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: S.of(context).appBarTitleBMI, // Localized title
        showBackButton: false,
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
              text: S.of(context).calculateButtonText,
              onPressed: _calculateBMI,
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
            S.of(context).calculateBMIDescription, // Localized description
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
            label: S.of(context).heightLabel,
            initialValue: _height,
            minValue: 50,
            maxValue: 350,
            onChanged: (newHeight) {
              setState(() {
                _height = newHeight;
              });
            },
          ),
          Spacing.mediumVertical,
          GenderSelector(
            initialGender: _selectedGender,
            onGenderChanged: (gender) {
              setState(() {
                _selectedGender = gender;
              });
            },
          ),
        ],
      ),
    );
  }
}
