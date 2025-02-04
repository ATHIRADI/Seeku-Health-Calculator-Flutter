import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seeku_health_calc/generated/l10n.dart';
import 'package:seeku_health_calc/utils/calculator_util.dart';
import 'package:seeku_health_calc/utils/providers/calories_result_provider.dart';
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
import 'package:seeku_health_calc/widgets/reusable_bg_card.dart';
import 'package:seeku_health_calc/widgets/reusable_dropdown.dart';
import 'package:seeku_health_calc/widgets/slider_card.dart';
import 'package:seeku_health_calc/widgets/responsive_layout.dart';

class CaloriesCalculatorScreen extends StatefulWidget {
  const CaloriesCalculatorScreen({super.key});

  @override
  CaloriesCalculatorScreenState createState() =>
      CaloriesCalculatorScreenState();
}

class CaloriesCalculatorScreenState extends State<CaloriesCalculatorScreen> {
  int _height = 170;
  int _weight = 70;
  int _age = 25;
  Gender _selectedGender = Gender.male;
  String _weightGoal = 'maintain';
  double _activityLevel = 1.2;

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

  void _calculateCalories() {
    _interstitialAdWidget.showAd();
    try {
      double calorieNeeds = CalculatorUtil.calculateCalorieNeeds(
        height: _height,
        weight: _weight,
        age: _age,
        gender: _selectedGender,
        goal: _weightGoal,
        activityLevel: _activityLevel,
      );

      Provider.of<CaloriesResultProvider>(context, listen: false).setResult(
        calorieNeeds: calorieNeeds,
        height: _height,
        weight: _weight,
        age: _age,
        gender: _selectedGender,
        goal: _weightGoal,
        activityLevel: _activityLevel,
      );

      _showResultDialog(calorieNeeds);
    } catch (e) {
      _showInputErrorDialog();
    }
  }

  void _showResultDialog(double calorieNeeds) {
    final localizations = S.of(context);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ResultDialog(
          title: localizations.caloriesResultTitle,
          resultCards: [
            ResultCard(
              icon: Icons.fastfood,
              title: localizations.caloriesResultLabel,
              value: "${calorieNeeds.round()} ${localizations.caloriesPerDay}",
              valueStyle: Theme.of(context).textTheme.displayMedium,
            ),
            Spacing.smallVertical,
            ResultCard(
              icon: Icons.info,
              title: localizations.weightGoalLabel,
              value:
                  CalculatorUtil.getWeightGoalDescription(context, _weightGoal),
              valueStyle: Theme.of(context).textTheme.titleLarge,
            ),
          ],
        );
      },
    );
  }

  void _showInputErrorDialog() {
    final localizations = S.of(context);

    showDialog(
      context: context,
      builder: (context) => InputErrorDialog(
        message: localizations.inputErrorMessage,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final localizations = S.of(context);

    return Scaffold(
      appBar: CustomAppBar(
        title: localizations.caloriesCalculatorTitle,
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
              text: S
                  .of(context)
                  .calculateCaloriesButton, // Localized button text
              onPressed: _calculateCalories,
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
    final localizations = S.of(context);

    return Padding(
      padding: padding ?? EdgeInsets.all(20),
      child: Column(
        children: [
          AdaptiveText(
            localizations.caloriesCalculatorDescription,
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
                  label: localizations.weightLabel,
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
                  label: localizations.ageLabel,
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
            label: localizations.heightLabel,
            initialValue: _height,
            minValue: 50,
            maxValue: 250,
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
          Spacing.mediumVertical,
          ReusableBgCard(
            cardChild: Column(
              children: [
                ReusableDropdown<String>(
                  label: localizations.weightGoalLabel,
                  value: _weightGoal,
                  items: [
                    DropdownMenuItem(
                      value: 'maintain',
                      child: AdaptiveText(
                        localizations.weightGoalMaintain,
                        mobileSize: 16,
                        tabletSize: 18,
                        desktopSize: 20,
                      ),
                    ),
                    DropdownMenuItem(
                      value: 'weightLoss',
                      child: AdaptiveText(
                        localizations.weightGoalLose,
                        mobileSize: 16,
                        tabletSize: 18,
                        desktopSize: 20,
                      ),
                    ),
                    DropdownMenuItem(
                      value: 'weightGain',
                      child: AdaptiveText(
                        localizations.weightGoalGain,
                        mobileSize: 16,
                        tabletSize: 18,
                        desktopSize: 20,
                      ),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _weightGoal = value!;
                    });
                  },
                ),
                Spacing.mediumVertical,
                ReusableDropdown<double>(
                  label: localizations.activityLevelLabel,
                  value: _activityLevel,
                  items: [
                    DropdownMenuItem(
                      value: 1.2,
                      child: AdaptiveText(
                        localizations.activityLevelSedentary,
                        mobileSize: 16,
                        tabletSize: 18,
                        desktopSize: 20,
                      ),
                    ),
                    DropdownMenuItem(
                      value: 1.375,
                      child: AdaptiveText(
                        localizations.activityLevelLightlyActive,
                        mobileSize: 16,
                        tabletSize: 18,
                        desktopSize: 20,
                      ),
                    ),
                    DropdownMenuItem(
                      value: 1.55,
                      child: AdaptiveText(
                        localizations.activityLevelModeratelyActive,
                        mobileSize: 16,
                        tabletSize: 18,
                        desktopSize: 20,
                      ),
                    ),
                    DropdownMenuItem(
                      value: 1.725,
                      child: AdaptiveText(
                        localizations.activityLevelVeryActive,
                        mobileSize: 16,
                        tabletSize: 18,
                        desktopSize: 20,
                      ),
                    ),
                    DropdownMenuItem(
                      value: 1.9,
                      child: AdaptiveText(
                        localizations.activityLevelExtraActive,
                        mobileSize: 16,
                        tabletSize: 18,
                        desktopSize: 20,
                      ),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _activityLevel = value!;
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
