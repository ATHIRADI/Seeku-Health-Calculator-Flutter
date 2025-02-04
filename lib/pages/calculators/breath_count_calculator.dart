import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seeku_health_calc/generated/l10n.dart';
import 'package:seeku_health_calc/utils/calculator_util.dart';
import 'package:seeku_health_calc/utils/providers/breath_count_result_provider.dart';
import 'package:seeku_health_calc/utils/spacing.dart';
import 'package:seeku_health_calc/widgets/adaptive_text.dart';
import 'package:seeku_health_calc/widgets/banner_ad_widget.dart';
import 'package:seeku_health_calc/widgets/custom_app_bar.dart';
import 'package:seeku_health_calc/widgets/custom_elevated_button.dart';
import 'package:seeku_health_calc/widgets/interstitial_ad_widget.dart';
import 'package:seeku_health_calc/widgets/responsive_layout.dart';
import 'package:seeku_health_calc/widgets/reusable_bg_card.dart';
import 'package:seeku_health_calc/widgets/result_card.dart';
import 'package:seeku_health_calc/widgets/result_dialog.dart';
import 'package:seeku_health_calc/widgets/slider_card.dart';

class BreathCountCalculatorScreen extends StatefulWidget {
  const BreathCountCalculatorScreen({super.key});

  @override
  BreathCountCalculatorScreenState createState() =>
      BreathCountCalculatorScreenState();
}

class BreathCountCalculatorScreenState
    extends State<BreathCountCalculatorScreen> {
  int _breathCount = 0;
  int _durationSeconds = 30;
  bool _isAdult = true;
  bool _isCounting = false;
  Timer? _countdownTimer;
  int _remainingTime = 0;

  final InterstitialAdWidget _interstitialAdWidget = InterstitialAdWidget();

  @override
  void initState() {
    super.initState();
    _interstitialAdWidget.loadInterstitialAd();
  }

  @override
  void dispose() {
    _interstitialAdWidget.dispose();
    _countdownTimer?.cancel();
    super.dispose();
  }

  void _startCounting() {
    _interstitialAdWidget.showAd();
    setState(() {
      _breathCount = 0;
      _isCounting = true;
      _remainingTime = _durationSeconds;
    });

    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _remainingTime--;
      });

      if (_remainingTime <= 0) {
        _stopCounting();
      }
    });
  }

  void _stopCounting() {
    _countdownTimer?.cancel();

    // Calculate breaths per minute
    int breathsPerMinute = CalculatorUtil.calculateBreathRate(
        context, _breathCount, _durationSeconds);

    // Get category
    String category = CalculatorUtil.getBreathRateCategory(
        context, breathsPerMinute, _isAdult);

    // Save to provider
    Provider.of<BreathCountResultProvider>(context, listen: false).setResult(
      breathCount: _breathCount,
      durationSeconds: _durationSeconds,
      breathsPerMinute: breathsPerMinute,
      category: category,
      isAdult: _isAdult,
    );

    // Show result dialog
    _showResultDialog(breathsPerMinute, category);

    setState(() {
      _isCounting = false;
    });
  }

  void _incrementBreathCount() {
    if (_isCounting) {
      setState(() {
        _breathCount++;
      });
    }
  }

  void _showResultDialog(int breathsPerMinute, String category) {
    Color categoryColor = CalculatorUtil.getBreathRateColor(context, category);
    // String description =
    //     CalculatorUtil.getBreathRateDescription(context, category);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ResultDialog(
          title: S.of(context).breathCountResultsTitle,
          resultCards: [
            ResultCard(
              icon: Icons.air,
              title: S.of(context).breathsPerMinuteLabel,
              value: '$breathsPerMinute',
              valueStyle: Theme.of(context)
                  .textTheme
                  .displayLarge
                  ?.copyWith(color: categoryColor),
            ),
            Spacing.smallVertical,
            ResultCard(
              icon: Icons.circle,
              iconColor: categoryColor,
              title: S.of(context).breathRateCategoryLabel,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Localized app bar title
      appBar: CustomAppBar(
        title: S.of(context).breathCountCalculatorTitle,
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
              text: S.of(context).startCountingButton, // Localized button text
              onPressed: _startCounting,
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
            // Localized "Count your breaths to measure respiratory rate"
            S.of(context).breathCountDescription,
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
            mobileSize: 16,
            tabletSize: 18,
            desktopSize: 20,
          ),
          Spacing.mediumVertical,
          // Replace hard-coded label with localized string
          SliderCard(
            label: S.of(context).measurementDurationLabel,
            initialValue: _durationSeconds,
            minValue: 15,
            maxValue: 60,
            onChanged: _isCounting
                ? null
                : (int value) {
                    setState(() {
                      _durationSeconds = value;
                    });
                  },
          ),
          Spacing.mediumVertical,
          ReusableBgCard(
            cardChild: Column(
              children: [
                AdaptiveText(
                  S.of(context).ageGroupLabel,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Row(
                  children: [
                    Expanded(
                      child: RadioListTile<bool>(
                        title: Text(S.of(context).adultLabel),
                        value: true,
                        groupValue: _isAdult,
                        onChanged: _isCounting
                            ? null
                            : (bool? value) {
                                setState(() {
                                  _isAdult = value!;
                                });
                              },
                      ),
                    ),
                    Expanded(
                      child: RadioListTile<bool>(
                        title: Text(S.of(context).childLabel),
                        value: false,
                        groupValue: _isAdult,
                        onChanged: _isCounting
                            ? null
                            : (bool? value) {
                                setState(() {
                                  _isAdult = value!;
                                });
                              },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Spacing.mediumVertical,
          if (_isCounting)
            ReusableBgCard(
              cardChild: Column(
                children: [
                  // AdaptiveText(
                  //   _isCounting
                  //       ? S.of(context).tapToCountBreathsLabel
                  //       : S.of(context).prepareToCountBreathsLabel,
                  //   style: Theme.of(context).textTheme.titleMedium,
                  // ),
                  // Spacing.mediumVertical,

                  Column(
                    children: [
                      AdaptiveText(
                        // "Time Remaining: $_remainingTime seconds"
                        "${S.of(context).timeRemainingLabel}: $_remainingTime seconds",
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      Spacing.mediumVertical,
                      AdaptiveText(
                        // "Breaths Counted: $_breathCount"
                        "${S.of(context).breathsCountedLabel}: $_breathCount",
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      Spacing.mediumVertical,
                      GestureDetector(
                        onTap: _incrementBreathCount,
                        child: Container(
                          width: 200,
                          height: 200,
                          decoration: BoxDecoration(
                            color: Colors.green.withOpacity(0.2),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.green,
                              width: 4,
                            ),
                          ),
                          child: Center(
                            child: AdaptiveText(
                              "TAP",
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium
                                  ?.copyWith(
                                    color: Colors.green,
                                  ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )

                  // : CustomElevatedButton(
                  //     text: S.of(context).startCountingButton,
                  //     onPressed: _startCounting,
                  //   ),
                ],
              ),
            ),
          Spacing.mediumVertical,
          ReusableBgCard(
            cardChild: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AdaptiveText(
                  S.of(context).breathCountGuidelinesTitle,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Spacing.smallVertical,
                AdaptiveText(
                  // Multi-line instructions
                  S.of(context).breathCountGuidelinesDescription,
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
