import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seeku_health_calc/generated/l10n.dart';
import 'package:seeku_health_calc/utils/calculator_util.dart';
import 'package:seeku_health_calc/utils/providers/ideal_weight_result_provider.dart';
import 'package:seeku_health_calc/utils/spacing.dart';
import 'package:seeku_health_calc/widgets/adaptive_text.dart';
import 'package:seeku_health_calc/widgets/banner_ad_widget.dart';
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

class IdealWeightCalculatorScreen extends StatefulWidget {
  const IdealWeightCalculatorScreen({super.key});

  @override
  IdealWeightCalculatorScreenState createState() =>
      IdealWeightCalculatorScreenState();
}

class IdealWeightCalculatorScreenState
    extends State<IdealWeightCalculatorScreen> {
  int _height = 170;
  Gender _selectedGender = Gender.male;
  String _calculationMethod = 'robinson';

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

  void _calculateIdealWeight() {
    _interstitialAdWidget.showAd();
    try {
      double idealWeight = CalculatorUtil.calculateIdealWeight(
        context,
        height: _height,
        gender: _selectedGender,
        method: _calculationMethod,
      );

      String idealWeightRange = CalculatorUtil.getIdealWeightRange(
        context,
        height: _height,
        gender: _selectedGender,
      );

      Provider.of<IdealWeightResultProvider>(context, listen: false).setResult(
        idealWeight: idealWeight,
        height: _height,
        gender: _selectedGender,
        calculationMethod: _calculationMethod,
        idealWeightRange: idealWeightRange,
      );

      _showResultDialog(idealWeight, idealWeightRange);
    } catch (e) {
      _showInputErrorDialog();
    }
  }

  void _showResultDialog(double idealWeight, String idealWeightRange) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ResultDialog(
          title: S.of(context).resultDialogTitle, // Localized title
          resultCards: [
            // Ideal Weight Card
            ResultCard(
              icon: Icons.monitor_weight,
              title: S.of(context).idealWeight, // Localized ideal weight
              value: "${idealWeight.toStringAsFixed(1)} kg",
              valueStyle: Theme.of(context).textTheme.displayLarge,
            ),
            Spacing.smallVertical,
            // Healthy Weight Range Card
            ResultCard(
              icon: Icons.heart_broken,
              iconColor: Colors.green,
              title: S
                  .of(context)
                  .healthyWeightRange, // Localized healthy weight range
              value: idealWeightRange,
              valueStyle: Theme.of(context)
                  .textTheme
                  .displayMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
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
        title: S.of(context).appBarTitleIdealWeight, // Localized title
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
              text: S.of(context).calculateButtonText, // Localized button text
              onPressed: _calculateIdealWeight,
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
            S
                .of(context)
                .calculateIdealWeightDescription, // Localized description
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
            mobileSize: 16,
            tabletSize: 18,
            desktopSize: 20,
          ),
          Spacing.mediumVertical,
          SliderCard(
            label: S.of(context).heightLabel,
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
                  label: S
                      .of(context)
                      .calculationMethodLabel, // Localized calculation method label
                  value: _calculationMethod,
                  items: [
                    DropdownMenuItem(
                      value: 'robinson',
                      child: AdaptiveText(
                        S.of(context).robinsonMethod, // Localized method
                        mobileSize: 16,
                        tabletSize: 18,
                        desktopSize: 20,
                      ),
                    ),
                    DropdownMenuItem(
                      value: 'miller',
                      child: AdaptiveText(
                        S.of(context).millerMethod, // Localized method
                        mobileSize: 16,
                        tabletSize: 18,
                        desktopSize: 20,
                      ),
                    ),
                    DropdownMenuItem(
                      value: 'devine',
                      child: AdaptiveText(
                        S.of(context).devineMethod, // Localized method
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
