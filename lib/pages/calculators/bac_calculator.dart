import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seeku_health_calc/generated/l10n.dart';
import 'package:seeku_health_calc/utils/calculator_util.dart';
import 'package:seeku_health_calc/utils/providers/bac_result_provider.dart';
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
import 'package:seeku_health_calc/widgets/responsive_layout.dart';
import 'package:seeku_health_calc/widgets/reusable_bg_card.dart';
import 'package:seeku_health_calc/widgets/reusable_dropdown.dart';

class BACCalculatorScreen extends StatefulWidget {
  const BACCalculatorScreen({super.key});

  @override
  BACCalculatorScreenState createState() => BACCalculatorScreenState();
}

class BACCalculatorScreenState extends State<BACCalculatorScreen> {
  double _weight = 70;
  Gender _selectedGender = Gender.male;
  double _alcoholConsumed = 1.0;
  double _hours = 1.0;
  String _drinkType = 'beer';

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

  void _calculateBAC() {
    _interstitialAdWidget.showAd();
    try {
      // Calculate BAC
      double bacLevel = CalculatorUtil.calculateBAC(
        weight: _weight,
        gender: _selectedGender,
        alcoholConsumed: _alcoholConsumed,
        hours: _hours,
      );

      // Get BAC category
      String bacCategory = CalculatorUtil.getBACCategory(context, bacLevel);

      // Get BAC effects
      List<Map<String, dynamic>> bacEffects =
          CalculatorUtil.getEffectsAtBAC(context, bacLevel);

      // Set result in provider
      Provider.of<BACResultProvider>(context, listen: false).setResult(
        bacLevel: bacLevel,
        weight: _weight,
        gender: _selectedGender,
        alcoholConsumed: _alcoholConsumed,
        hours: _hours,
        bacCategory: bacCategory,
        bacEffects: bacEffects,
      );

      // Show result dialog
      _showResultDialog(bacLevel, bacCategory);
    } catch (e) {
      _showInputErrorDialog();
    }
  }

  void _showResultDialog(double bacLevel, String bacCategory) {
    final localizations = S.of(context);
    Color bacColor = CalculatorUtil.getBACCategoryColor(bacLevel);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ResultDialog(
          title: localizations.bacResultTitle,
          resultCards: [
            ResultCard(
              icon: Icons.local_drink,
              title: localizations.bacLevelLabel,
              value: "${bacLevel.toStringAsFixed(3)}%",
              valueStyle: Theme.of(context)
                  .textTheme
                  .displayLarge!
                  .copyWith(color: bacColor),
            ),
            Spacing.smallVertical,
            ResultCard(
              icon: Icons.circle,
              iconColor: bacColor,
              title: localizations.bacCategoryLabel,
              value: bacCategory,
              valueStyle: Theme.of(context)
                  .textTheme
                  .displayMedium
                  ?.copyWith(color: bacColor),
            ),
            // Here we use atBACLevel with the placeholder
            ...Provider.of<BACResultProvider>(context, listen: false)
                .bacEffects!
                .map((effect) => Column(
                      children: [
                        Spacing.smallVertical,
                        ResultCard(
                          icon: Icons.warning,
                          title: localizations.atBACLevel(
                            effect['bac'].toString(),
                          ),
                          value: effect['effects'].toString(),
                          valueStyle: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    )),
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
        title: localizations.bacCalculatorTitle,
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
              text: S.of(context).calculateBACButton, // Localized button text
              onPressed: _calculateBAC,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildContent({EdgeInsets? padding}) {
    final localizations = S.of(context);

    return Padding(
      padding: padding ?? EdgeInsets.all(20),
      child: Column(
        children: [
          AdaptiveText(
            localizations.calculateBACDescription,
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
            mobileSize: 16,
            tabletSize: 18,
            desktopSize: 20,
          ),
          Spacing.mediumVertical,
          CounterCard(
            label: localizations.weightLabel,
            initialValue: _weight.toInt(),
            minValue: 30,
            maxValue: 300,
            onChanged: (value) {
              setState(() {
                _weight = value.toDouble();
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
                AdaptiveText(
                  localizations.alcoholConsumptionTitle,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Spacing.smallVertical,
                ReusableDropdown<String>(
                  label: localizations.drinkTypeLabel,
                  value: _drinkType,
                  items: [
                    DropdownMenuItem(
                      value: 'beer',
                      child: AdaptiveText(localizations.drinkTypeBeer),
                    ),
                    DropdownMenuItem(
                      value: 'wine',
                      child: AdaptiveText(localizations.drinkTypeWine),
                    ),
                    DropdownMenuItem(
                      value: 'spirits',
                      child: AdaptiveText(localizations.drinkTypeSpirits),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _drinkType = value!;
                    });
                  },
                ),
                Spacing.mediumVertical,
                CounterCard(
                  label: localizations.drinksLabel,
                  initialValue: _alcoholConsumed.toInt(),
                  minValue: 0,
                  maxValue: 20,
                  onChanged: (value) {
                    setState(() {
                      _alcoholConsumed = value.toDouble();
                    });
                  },
                ),
              ],
            ),
          ),
          Spacing.mediumVertical,
          CounterCard(
            label: localizations.hoursSinceDrinkingLabel,
            initialValue: _hours.toInt(),
            minValue: 0,
            maxValue: 24,
            onChanged: (value) {
              setState(() {
                _hours = value.toDouble();
              });
            },
          ),
          Spacing.mediumVertical,
          ReusableBgCard(
            cardChild: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AdaptiveText(
                  localizations.importantSafetyInfoTitle,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Spacing.smallVertical,
                AdaptiveText(
                  localizations.safetyInfoText,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
