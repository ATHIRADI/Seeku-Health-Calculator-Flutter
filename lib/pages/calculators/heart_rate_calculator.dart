import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seeku_health_calc/generated/l10n.dart';
import 'package:seeku_health_calc/utils/calculator_util.dart';
import 'package:seeku_health_calc/utils/providers/heart_rate_result_provider.dart';
import 'package:seeku_health_calc/utils/spacing.dart';
import 'package:seeku_health_calc/widgets/adaptive_text.dart';
import 'package:seeku_health_calc/widgets/banner_ad_widget.dart';
import 'package:seeku_health_calc/widgets/counter_card.dart';
import 'package:seeku_health_calc/widgets/custom_app_bar.dart';
import 'package:seeku_health_calc/widgets/custom_elevated_button.dart';
import 'package:seeku_health_calc/widgets/interstitial_ad_widget.dart';
import 'package:seeku_health_calc/widgets/reusable_bg_card.dart';
import 'package:seeku_health_calc/widgets/responsive_layout.dart';
import 'package:seeku_health_calc/widgets/result_card.dart';
import 'package:seeku_health_calc/widgets/result_dialog.dart';

class HeartRateCalculatorScreen extends StatefulWidget {
  const HeartRateCalculatorScreen({super.key});

  @override
  HeartRateCalculatorScreenState createState() =>
      HeartRateCalculatorScreenState();
}

class HeartRateCalculatorScreenState extends State<HeartRateCalculatorScreen> {
  int _age = 30;
  String _calculationMethod = 'traditional';

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

  void _calculateHeartRate() {
    _interstitialAdWidget.showAd();
    try {
      int maxHeartRate = CalculatorUtil.calculateMaxHeartRate(_age);
      Map<String, int> heartRateZones =
          CalculatorUtil.calculateHeartRateZones(maxHeartRate);

      Provider.of<HeartRateResultProvider>(context, listen: false).setResult(
        maxHeartRate: maxHeartRate,
        age: _age,
        heartRateZones: heartRateZones,
      );

      _showResultDialog(maxHeartRate, heartRateZones);
    } catch (e) {
      _showInputErrorDialog();
    }
  }

  void _showResultDialog(int maxHeartRate, Map<String, int> heartRateZones) {
    final localizations = S.of(context);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ResultDialog(
          title: localizations.heartRateResultTitle,
          resultCards: [
            ResultCard(
              icon: Icons.favorite,
              title: localizations.maxHeartRateLabel,
              value: "$maxHeartRate bpm",
              valueStyle: Theme.of(context).textTheme.displayLarge,
            ),
            Spacing.smallVertical,
            ...heartRateZones.entries.map((entry) {
              return Column(
                children: [
                  ResultCard(
                    icon: Icons.access_alarm,
                    title: entry.key,
                    value: "${entry.value} bpm",
                    valueStyle: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Spacing.smallVertical,
                ],
              );
            }),
          ],
        );
      },
    );
  }

  void _showInputErrorDialog() {
    final localizations = S.of(context);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: AdaptiveText("Invalid Input"),
        content: AdaptiveText(
          localizations.inputErrorMessage,
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

  @override
  Widget build(BuildContext context) {
    final localizations = S.of(context);

    return Scaffold(
      appBar: CustomAppBar(
        title: localizations.heartRateCalculatorTitle,
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
                  .calculateHeartRateButton, // Localized button text
              onPressed: _calculateHeartRate,
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
            localizations.heartRateCalculatorDescription,
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
            mobileSize: 16,
            tabletSize: 18,
            desktopSize: 20,
          ),
          Spacing.mediumVertical,
          CounterCard(
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
          Spacing.mediumVertical,
          ReusableBgCard(
            cardChild: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AdaptiveText(
                  localizations.calculationMethodLabel,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                SizedBox(
                  width: double.infinity,
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: _calculationMethod,
                    items: [
                      DropdownMenuItem(
                        value: 'traditional',
                        child: AdaptiveText(localizations.traditionalMethod),
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        _calculationMethod = value!;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          Spacing.mediumVertical,
          ReusableBgCard(
            cardChild: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AdaptiveText(
                  localizations.heartRateZoneInformationTitle,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Spacing.smallVertical,
                AdaptiveText(
                  localizations.heartRateZonesInfo,
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
