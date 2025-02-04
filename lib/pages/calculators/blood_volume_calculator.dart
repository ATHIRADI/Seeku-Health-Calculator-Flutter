import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seeku_health_calc/generated/l10n.dart';
import 'package:seeku_health_calc/utils/calculator_util.dart';
import 'package:seeku_health_calc/utils/providers/blood_volume_result_provider.dart';
import 'package:seeku_health_calc/utils/spacing.dart';
import 'package:seeku_health_calc/widgets/adaptive_text.dart';
import 'package:seeku_health_calc/widgets/banner_ad_widget.dart';
import 'package:seeku_health_calc/widgets/counter_card.dart';
import 'package:seeku_health_calc/widgets/custom_app_bar.dart';
import 'package:seeku_health_calc/widgets/custom_elevated_button.dart';
import 'package:seeku_health_calc/widgets/gender_selector.dart';
import 'package:seeku_health_calc/widgets/input_error_dialog.dart';
import 'package:seeku_health_calc/widgets/interstitial_ad_widget.dart';
import 'package:seeku_health_calc/widgets/responsive_layout.dart';
import 'package:seeku_health_calc/widgets/result_card.dart';
import 'package:seeku_health_calc/widgets/result_dialog.dart';
import 'package:seeku_health_calc/widgets/reusable_bg_card.dart';
import 'package:seeku_health_calc/widgets/reusable_dropdown.dart';

class BloodVolumeCalculatorScreen extends StatefulWidget {
  const BloodVolumeCalculatorScreen({super.key});

  @override
  BloodVolumeCalculatorScreenState createState() =>
      BloodVolumeCalculatorScreenState();
}

class BloodVolumeCalculatorScreenState
    extends State<BloodVolumeCalculatorScreen> {
  int _weight = 70;
  Gender _selectedGender = Gender.male;
  String _calculationMethod = 'standard';

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

  void _calculateBloodVolume() {
    _interstitialAdWidget.showAd();
    try {
      double bloodVolume = CalculatorUtil.calculateBloodVolume(
        context,
        weight: _weight,
        gender: _selectedGender,
        method: _calculationMethod,
      );

      String category =
          CalculatorUtil.getBloodVolumeCategory(context, bloodVolume);
      Map<String, dynamic> riskFactors =
          CalculatorUtil.getBloodVolumeRiskFactors(bloodVolume);

      Provider.of<BloodVolumeResultProvider>(context, listen: false).setResult(
        bloodVolume: bloodVolume,
        weight: _weight,
        gender: _selectedGender,
        category: category,
        calculationMethod: _calculationMethod,
        riskFactors: riskFactors,
      );

      _showResultDialog(bloodVolume, category, riskFactors);
    } catch (e) {
      _showInputErrorDialog();
    }
  }

  void _showResultDialog(
    double bloodVolume,
    String category,
    Map<String, dynamic> riskFactors,
  ) {
    final localizations = S.of(context);
    Color categoryColor = CalculatorUtil.getBloodVolumeColor(category);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ResultDialog(
          title: localizations.bloodVolumeResultTitle,
          resultCards: [
            ResultCard(
              icon: Icons.bloodtype,
              title: localizations.totalBloodVolumeLabel,
              value: "${bloodVolume.toStringAsFixed(0)} mL",
              valueStyle: Theme.of(context)
                  .textTheme
                  .displayMedium!
                  .copyWith(color: categoryColor),
            ),
            Spacing.smallVertical,
            ResultCard(
              icon: Icons.circle,
              iconColor: categoryColor,
              title: localizations.bloodVolumeCategoryLabel,
              value: category,
              valueStyle: Theme.of(context)
                  .textTheme
                  .displayMedium
                  ?.copyWith(color: categoryColor),
            ),
            Spacing.smallVertical,
            ResultCard(
              icon: Icons.warning,
              title: localizations.lowRiskThresholdLabel,
              value: "${riskFactors['lowRisk'].toStringAsFixed(0)} mL",
            ),
            Spacing.smallVertical,
            ResultCard(
              icon: Icons.dangerous,
              title: localizations.highRiskThresholdLabel,
              value: "${riskFactors['highRisk'].toStringAsFixed(0)} mL",
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
        message: localizations.inputErrorBloodVolume,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final localizations = S.of(context);

    return Scaffold(
      appBar: CustomAppBar(
        title: localizations.bloodVolumeCalculatorTitle,
        showBackButton: true,
      ),
      body: ResponsiveLayout(
        mobile: _buildMobileLayout(),
        tablet: _buildTabletLayout(),
        desktop: _buildDesktopLayout(),
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
                  .calculateBloodVolumeButton, // Localized button text
              onPressed: _calculateBloodVolume,
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
            localizations.calculateBloodVolumeDescription,
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
            mobileSize: 16,
            tabletSize: 18,
            desktopSize: 20,
          ),
          Spacing.mediumVertical,
          CounterCard(
            label: localizations.weightLabel,
            initialValue: _weight,
            minValue: 10,
            maxValue: 300,
            onChanged: (value) {
              setState(() {
                _weight = value;
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
            cardChild: ReusableDropdown<String>(
              label: localizations.calculationMethodLabel,
              value: _calculationMethod,
              items: [
                DropdownMenuItem(
                  value: 'standard',
                  child: AdaptiveText(localizations.standardMethod),
                ),
                DropdownMenuItem(
                  value: 'detailed',
                  child: AdaptiveText(localizations.detailedMethod),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  _calculationMethod = value!;
                });
              },
            ),
          ),
          Spacing.mediumVertical,
          ReusableBgCard(
            cardChild: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AdaptiveText(
                  localizations.bloodVolumeInformationTitle,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Spacing.smallVertical,
                AdaptiveText(
                  localizations.bloodVolumeInformationDetail,
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
