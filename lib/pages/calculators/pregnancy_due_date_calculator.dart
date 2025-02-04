import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:seeku_health_calc/generated/l10n.dart';
import 'package:seeku_health_calc/utils/calculator_util.dart';
import 'package:seeku_health_calc/utils/providers/pregnancy_due_date_result_provider.dart';
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
import 'package:seeku_health_calc/widgets/reusable_dropdown.dart';

class PregnancyDueDateCalculatorScreen extends StatefulWidget {
  const PregnancyDueDateCalculatorScreen({super.key});

  @override
  createState() => PregnancyDueDateCalculatorScreenState();
}

class PregnancyDueDateCalculatorScreenState
    extends State<PregnancyDueDateCalculatorScreen> {
  DateTime? _lastMenstrualPeriod;
  String _calculationMethod = 'naegele';

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

  void _calculateDueDate() {
    _interstitialAdWidget.showAd();
    if (_lastMenstrualPeriod == null) {
      _showInputErrorDialog();
      return;
    }

    try {
      DateTime dueDate = CalculatorUtil.calculateDueDate(
        context,
        _lastMenstrualPeriod!,
        method: _calculationMethod,
      );

      int gestationalAge =
          CalculatorUtil.calculateGestationalAge(_lastMenstrualPeriod!);

      String trimester =
          CalculatorUtil.getPregnancyTrimester(context, gestationalAge);

      Provider.of<PregnancyDueDateResultProvider>(context, listen: false)
          .setResult(
        lastMenstrualPeriod: _lastMenstrualPeriod!,
        dueDate: dueDate,
        gestationalAge: gestationalAge,
        trimester: trimester,
        calculationMethod: _calculationMethod,
      );

      _showResultDialog(dueDate, gestationalAge, trimester);
    } catch (e) {
      _showInputErrorDialog();
    }
  }

  void _showResultDialog(
      DateTime dueDate, int gestationalAge, String trimester) {
    final localizations = S.of(context);
    final dateFormat = DateFormat('MMMM dd, yyyy');

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ResultDialog(
          title: localizations.pregnancyDueDateResultTitle,
          resultCards: [
            ResultCard(
              icon: Icons.calendar_today,
              title: localizations.estimatedDueDateLabel,
              value: dateFormat.format(dueDate),
              valueStyle: Theme.of(context).textTheme.displayMedium,
            ),
            Spacing.smallVertical,
            ResultCard(
              icon: Icons.pregnant_woman,
              title: localizations.gestationalAgeLabel,
              value: "$gestationalAge ${localizations.weeks}",
              valueStyle: Theme.of(context).textTheme.displayMedium,
            ),
            Spacing.smallVertical,
            ResultCard(
              icon: Icons.trending_up,
              title: localizations.currentTrimesterLabel,
              value: trimester,
              valueStyle: Theme.of(context).textTheme.displayMedium,
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
        message: localizations.inputErrorPregnancyDate,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final localizations = S.of(context);

    return Scaffold(
      appBar: CustomAppBar(
        title: localizations.pregnancyDueDateCalculatorTitle,
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
              text:
                  S.of(context).calculateDueDateButton, // Localized button text
              onPressed: _calculateDueDate,
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
            localizations.calculatePregnancyDueDateDescription,
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
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
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
          ReusableBgCard(
            cardChild: Column(
              children: [
                ReusableDropdown<String>(
                  label: localizations.calculationMethodLabel,
                  value: _calculationMethod,
                  items: [
                    DropdownMenuItem(
                      value: 'naegele',
                      child: AdaptiveText(localizations.naegeleMethod),
                    ),
                    DropdownMenuItem(
                      value: 'mittendorf',
                      child: AdaptiveText(localizations.mittendorfMethod),
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
          Spacing.mediumVertical,
          ReusableBgCard(
            cardChild: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AdaptiveText(
                  localizations.pregnancyTrimesterInformationTitle,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Spacing.smallVertical,
                AdaptiveText(
                  localizations.pregnancyTrimesterInfo,
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
