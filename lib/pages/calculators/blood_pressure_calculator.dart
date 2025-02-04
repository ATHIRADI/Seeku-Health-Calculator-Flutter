import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seeku_health_calc/generated/l10n.dart';
import 'package:seeku_health_calc/utils/calculator_util.dart';
import 'package:seeku_health_calc/utils/providers/blood_pressure_result_provider.dart';
import 'package:seeku_health_calc/utils/spacing.dart';
import 'package:seeku_health_calc/widgets/adaptive_text.dart';
import 'package:seeku_health_calc/widgets/banner_ad_widget.dart';
import 'package:seeku_health_calc/widgets/counter_card.dart';
import 'package:seeku_health_calc/widgets/custom_app_bar.dart';
import 'package:seeku_health_calc/widgets/custom_elevated_button.dart';
import 'package:seeku_health_calc/widgets/input_error_dialog.dart';
import 'package:seeku_health_calc/widgets/interstitial_ad_widget.dart';
import 'package:seeku_health_calc/widgets/result_card.dart';
import 'package:seeku_health_calc/widgets/result_dialog.dart';
import 'package:seeku_health_calc/widgets/responsive_layout.dart';
import 'package:seeku_health_calc/widgets/reusable_bg_card.dart';
import 'package:seeku_health_calc/widgets/reusable_dropdown.dart';

class BloodPressureCalculatorScreen extends StatefulWidget {
  const BloodPressureCalculatorScreen({super.key});

  @override
  BloodPressureCalculatorScreenState createState() =>
      BloodPressureCalculatorScreenState();
}

class BloodPressureCalculatorScreenState
    extends State<BloodPressureCalculatorScreen> {
  int _systolic = 120;
  int _diastolic = 80;
  String _measurementMethod = 'manual';

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

  void _calculateBloodPressure() {
    _interstitialAdWidget.showAd();
    try {
      String category = CalculatorUtil.getBloodPressureCategory(
          context, _systolic, _diastolic);
      String risk = CalculatorUtil.getBloodPressureRisk(context, category);
      Color categoryColor =
          CalculatorUtil.getBloodPressureColor(context, category);

      Provider.of<BloodPressureResultProvider>(context, listen: false)
          .setResult(
        systolic: _systolic,
        diastolic: _diastolic,
        category: category,
        risk: risk,
        categoryColor: categoryColor,
      );

      _showResultDialog(category, risk, categoryColor);
    } catch (e) {
      _showInputErrorDialog();
    }
  }

  void _showResultDialog(String category, String risk, Color categoryColor) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ResultDialog(
          // Use localized title
          title: S.of(context).bloodPressureCalculatorTitle,
          resultCards: [
            ResultCard(
              icon: Icons.favorite,
              // Localized "Blood Pressure Reading"
              title: S.of(context).bloodPressureReadingTitle,
              value: "$_systolic / $_diastolic mmHg",
              valueStyle: Theme.of(context)
                  .textTheme
                  .displayMedium!
                  .copyWith(color: categoryColor),
            ),
            Spacing.smallVertical,
            ResultCard(
              icon: Icons.circle,
              iconColor: categoryColor,
              // Localized label for "Category"
              title: S.of(context).bloodPressureCategoryLabel,
              value: category,
              valueStyle: Theme.of(context)
                  .textTheme
                  .displayMedium
                  ?.copyWith(color: categoryColor),
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
        // Localized input error
        message: S.of(context).bloodPressureInputError,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Localized app bar title
      appBar: CustomAppBar(
        title: S.of(context).bloodPressureCalculatorTitle,
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
                  .calculateBloodPressureButton, // Localized button text
              onPressed: _calculateBloodPressure,
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
      padding: padding ?? const EdgeInsets.all(20),
      child: Column(
        children: [
          AdaptiveText(
            // Localized helper text
            S.of(context).calculateBloodPressureDescription,
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
            mobileSize: 16,
            tabletSize: 18,
            desktopSize: 20,
          ),
          Spacing.mediumVertical,
          ReusableBgCard(
            cardChild: ReusableDropdown<String>(
              // Localized label
              label: S.of(context).measurementMethodLabel,
              value: _measurementMethod,
              items: [
                DropdownMenuItem(
                  value: 'manual',
                  child: AdaptiveText(S.of(context).measurementMethodManual),
                ),
                DropdownMenuItem(
                  value: 'device',
                  child: AdaptiveText(S.of(context).measurementMethodDevice),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  _measurementMethod = value!;
                });
              },
            ),
          ),
          Spacing.mediumVertical,
          Column(
            children: [
              CounterCard(
                label: "Systolic (Top Number)",
                initialValue: _systolic,
                minValue: 70,
                maxValue: 250,
                onChanged: (value) {
                  setState(() {
                    _systolic = value;
                  });
                },
              ),
              Spacing.mediumVertical,
              CounterCard(
                label: "Diastolic (Bottom Number)",
                initialValue: _diastolic,
                minValue: 40,
                maxValue: 150,
                onChanged: (value) {
                  setState(() {
                    _diastolic = value;
                  });
                },
              ),
            ],
          ),
          Spacing.mediumVertical,
          ReusableBgCard(
            cardChild: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AdaptiveText(
                  // Localized "Blood Pressure Categories"
                  S.of(context).bloodPressureCategoriesTitle,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Spacing.smallVertical,
                _buildBloodPressureCategory(
                  // Hypotension
                  S.of(context).bloodPressureCategoryHypotension,
                  S.of(context).bloodPressureRangeHypotension,
                  Colors.blue,
                ),
                _buildBloodPressureCategory(
                  S.of(context).bloodPressureCategoryNormal,
                  S.of(context).bloodPressureRangeNormal,
                  Colors.green,
                ),
                _buildBloodPressureCategory(
                  S.of(context).bloodPressureCategoryElevated,
                  S.of(context).bloodPressureRangeElevated,
                  Colors.lightGreen,
                ),
                _buildBloodPressureCategory(
                  S.of(context).bloodPressureCategoryHypertensionStage1,
                  S.of(context).bloodPressureRangeHypertensionStage1,
                  Colors.orange,
                ),
                _buildBloodPressureCategory(
                  S.of(context).bloodPressureCategoryHypertensionStage2,
                  S.of(context).bloodPressureRangeHypertensionStage2,
                  Colors.deepOrange,
                ),
                _buildBloodPressureCategory(
                  S.of(context).bloodPressureCategoryHypertensiveCrisis,
                  S.of(context).bloodPressureRangeHypertensiveCrisis,
                  Colors.red,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBloodPressureCategory(
    String category,
    String range,
    Color color,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Container(
            width: 15,
            height: 15,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          Spacing.smallHorizontal,
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(category),
                Text(range),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
