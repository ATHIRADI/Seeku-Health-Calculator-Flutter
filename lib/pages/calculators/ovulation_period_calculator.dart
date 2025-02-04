import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:seeku_health_calc/generated/l10n.dart';
import 'package:seeku_health_calc/utils/calculator_util.dart';
import 'package:seeku_health_calc/utils/providers/ovulation_period_result_provider.dart';
import 'package:seeku_health_calc/utils/spacing.dart';
import 'package:seeku_health_calc/widgets/adaptive_text.dart';
import 'package:seeku_health_calc/widgets/banner_ad_widget.dart';
import 'package:seeku_health_calc/widgets/custom_app_bar.dart';
import 'package:seeku_health_calc/widgets/custom_elevated_button.dart';
import 'package:seeku_health_calc/widgets/input_error_dialog.dart';
import 'package:seeku_health_calc/widgets/interstitial_ad_widget.dart';
import 'package:seeku_health_calc/widgets/result_card.dart';
import 'package:seeku_health_calc/widgets/result_dialog.dart';
import 'package:seeku_health_calc/widgets/responsive_layout.dart';
import 'package:seeku_health_calc/widgets/reusable_bg_card.dart';
import 'package:seeku_health_calc/widgets/slider_card.dart';

class OvulationPeriodCalculatorScreen extends StatefulWidget {
  const OvulationPeriodCalculatorScreen({super.key});

  @override
  OvulationPeriodCalculatorScreenState createState() =>
      OvulationPeriodCalculatorScreenState();
}

class OvulationPeriodCalculatorScreenState
    extends State<OvulationPeriodCalculatorScreen> {
  DateTime? _lastMenstrualPeriod;
  int _cycleDuration = 28;

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

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != _lastMenstrualPeriod) {
      setState(() {
        _lastMenstrualPeriod = picked;
      });
    }
  }

  void _calculateOvulationPeriod() {
    _interstitialAdWidget.showAd();
    if (_lastMenstrualPeriod == null) {
      _showInputErrorDialog();
      return;
    }

    try {
      DateTime ovulationDate = CalculatorUtil.calculateOvulationDate(
        _lastMenstrualPeriod!,
        cycleDuration: _cycleDuration,
      );

      List<DateTime> fertileWindow = CalculatorUtil.calculateFertileWindow(
        _lastMenstrualPeriod!,
        cycleDuration: _cycleDuration,
      );

      Provider.of<OvulationPeriodResultProvider>(context, listen: false)
          .setResult(
        lastMenstrualPeriod: _lastMenstrualPeriod!,
        ovulationDate: ovulationDate,
        fertileWindow: fertileWindow,
        cycleDuration: _cycleDuration,
      );

      _showResultDialog(ovulationDate, fertileWindow);
    } catch (e) {
      _showInputErrorDialog();
    }
  }

  void _showResultDialog(DateTime ovulationDate, List<DateTime> fertileWindow) {
    final localizations = S.of(context);
    final dateFormat = DateFormat('MMMM dd, yyyy');

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ResultDialog(
          title: localizations.ovulationPeriodResultTitle,
          resultCards: [
            ResultCard(
              icon: Icons.calendar_today,
              title: localizations.estimatedOvulationDateLabel,
              value: dateFormat.format(ovulationDate),
              valueStyle: Theme.of(context).textTheme.displayMedium,
            ),
            Spacing.smallVertical,
            ResultCard(
              icon: Icons.favorite,
              title: localizations.fertileWindowLabel,
              value: fertileWindow
                  .map((date) => dateFormat.format(date))
                  .join('\n'),
              valueStyle: Theme.of(context).textTheme.titleMedium,
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
        message: localizations.inputErrorOvulationDate,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final localizations = S.of(context);

    return Scaffold(
      appBar: CustomAppBar(
        title: localizations.ovulationPeriodCalculatorTitle,
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
                  .calculateOvulationButton, // Localized button text
              onPressed: _calculateOvulationPeriod,
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
    final dateFormat = DateFormat('MMMM dd, yyyy');

    return Padding(
      padding: padding ?? EdgeInsets.all(20),
      child: Column(
        children: [
          AdaptiveText(
            localizations.calculateOvulationDescription,
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
            mobileSize: 16,
            tabletSize: 18,
            desktopSize: 20,
          ),
          Spacing.mediumVertical,
          ReusableBgCard(
            cardChild: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AdaptiveText(
                  localizations.firstDayOfLastMenstrualPeriod,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Spacing.smallVertical,
                GestureDetector(
                  onTap: () => _selectDate(context),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      vertical: 15,
                      horizontal: 10,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Theme.of(context).primaryColor),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: AdaptiveText(
                      _lastMenstrualPeriod != null
                          ? dateFormat.format(_lastMenstrualPeriod!)
                          : localizations.selectDate,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Spacing.mediumVertical,
          SliderCard(
            label: localizations.menstrualCycleDurationLabel,
            initialValue: _cycleDuration,
            minValue: 21,
            maxValue: 35,
            onChanged: (value) {
              setState(() {
                _cycleDuration = value;
              });
            },
          ),
          Spacing.mediumVertical,
          ReusableBgCard(
            cardChild: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AdaptiveText(
                  localizations.menstrualCyclePhasesLabel,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Spacing.smallVertical,
                AdaptiveText(
                  localizations.menstrualCyclePhasesDescription,
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
