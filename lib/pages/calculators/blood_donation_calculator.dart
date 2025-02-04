import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:seeku_health_calc/generated/l10n.dart';
import 'package:seeku_health_calc/utils/calculator_util.dart';
import 'package:seeku_health_calc/utils/providers/blood_donation_result_provider.dart';
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

class BloodDonationCalculatorScreen extends StatefulWidget {
  const BloodDonationCalculatorScreen({super.key});

  @override
  BloodDonationCalculatorScreenState createState() =>
      BloodDonationCalculatorScreenState();
}

class BloodDonationCalculatorScreenState
    extends State<BloodDonationCalculatorScreen> {
  DateTime? _lastDonationDate;
  int _age = 25;
  double _weight = 70;
  Gender _gender = Gender.male;
  String _donationType = 'whole_blood';
  bool _hasRecentMedicalConditions = false;
  bool _hasTravelHistory = false;

  late DateFormat _dateFormat;

  final InterstitialAdWidget _interstitialAdWidget = InterstitialAdWidget();

  @override
  void initState() {
    super.initState();
    _dateFormat = DateFormat('MMMM dd, yyyy');
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

    if (picked != null && picked != _lastDonationDate) {
      setState(() {
        _lastDonationDate = picked;
      });
    }
  }

  void _calculateBloodDonation() {
    _interstitialAdWidget.showAd();
    final localizations = S.of(context);

    if (_lastDonationDate == null) {
      _showInputErrorDialog(localizations.inputErrorLastDonationDate);
      return;
    }

    try {
      bool isEligible = CalculatorUtil.isEligibleToDonate(
          _age, _weight, _hasRecentMedicalConditions, _hasTravelHistory);

      DateTime nextDonationDate = CalculatorUtil.calculateNextDonationDate(
          context, _lastDonationDate!, _donationType, _gender);

      int daysUntilNextDonation = CalculatorUtil.calculateDaysUntilNextDonation(
          context, _lastDonationDate!, _donationType, _gender);

      Provider.of<BloodDonationResultProvider>(context, listen: false)
          .setResult(
        lastDonationDate: _lastDonationDate!,
        nextDonationDate: nextDonationDate,
        daysUntilNextDonation: daysUntilNextDonation,
        donationType: _donationType,
        gender: _gender,
        isEligible: isEligible,
      );

      _showResultDialog(nextDonationDate, daysUntilNextDonation, isEligible);
    } catch (e) {
      _showInputErrorDialog(localizations.inputErrorGeneral);
    }
  }

  void _showResultDialog(
      DateTime nextDonationDate, int daysUntilNextDonation, bool isEligible) {
    final localizations = S.of(context);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ResultDialog(
          title: localizations.bloodDonationResultTitle,
          resultCards: [
            ResultCard(
              icon: Icons.bloodtype,
              title: localizations.donationTypeLabel,
              value: _getDonationTypeDescription(context, _donationType),
              valueStyle: Theme.of(context).textTheme.displayMedium,
            ),
            Spacing.smallVertical,
            ResultCard(
              icon: Icons.calendar_today,
              title: localizations.nextDonationDateLabel,
              value: _dateFormat.format(nextDonationDate),
              valueStyle: Theme.of(context).textTheme.displayMedium,
            ),
            Spacing.smallVertical,
            ResultCard(
              icon: Icons.timer,
              title: localizations.daysUntilNextDonationLabel,
              value: "$daysUntilNextDonation ${localizations.days}",
              valueStyle: Theme.of(context).textTheme.displayMedium,
            ),
            Spacing.smallVertical,
            ResultCard(
              icon: isEligible ? Icons.check_circle : Icons.cancel,
              iconColor: isEligible ? Colors.green : Colors.red,
              title: localizations.eligibilityStatusLabel,
              value: isEligible
                  ? localizations.eligibleStatus
                  : localizations.notEligibleStatus,
              valueStyle: Theme.of(context)
                  .textTheme
                  .displayMedium
                  ?.copyWith(color: isEligible ? Colors.green : Colors.red),
            ),
          ],
        );
      },
    );
  }

  String _getDonationTypeDescription(
      BuildContext context, String donationType) {
    final localizations = S.of(context);
    switch (donationType) {
      case 'whole_blood':
        return localizations.wholeBloodDonationType;
      case 'double_red_cells':
        return localizations.doubleRedCellsDonationType;
      case 'platelet':
        return localizations.plateletDonationType;
      case 'plasma':
        return localizations.plasmaDonationType;
      default:
        return donationType;
    }
  }

  void _showInputErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => InputErrorDialog(
        message: message,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final localizations = S.of(context);

    return Scaffold(
      appBar: CustomAppBar(
        title: localizations.bloodDonationCalculatorTitle,
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
              text: S
                  .of(context)
                  .calculateDonationDetailsButton, // Localized button text
              onPressed: _calculateBloodDonation,
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
            localizations.calculateBloodDonationDescription,
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
            mobileSize: 16,
            tabletSize: 18,
            desktopSize: 20,
          ),
          Spacing.mediumVertical,
          // Last Donation Date
          ReusableBgCard(
            cardChild: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AdaptiveText(
                  localizations.lastDonationDateLabel,
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
                      _lastDonationDate != null
                          ? _dateFormat.format(_lastDonationDate!)
                          : localizations.selectDate,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Spacing.mediumVertical,
          // Age and Weight
          Row(
            children: [
              Expanded(
                child: CounterCard(
                  label: localizations.ageLabel,
                  initialValue: _age,
                  minValue: 16,
                  maxValue: 65,
                  onChanged: (value) {
                    setState(() {
                      _age = value;
                    });
                  },
                ),
              ),
              Spacing.mediumHorizontal,
              Expanded(
                child: CounterCard(
                  label: localizations.weightLabel,
                  initialValue: _weight.toInt(),
                  minValue: 50,
                  maxValue: 200,
                  onChanged: (value) {
                    setState(() {
                      _weight = value.toDouble();
                    });
                  },
                ),
              ),
            ],
          ),
          Spacing.mediumVertical,
          // Gender Selector
          GenderSelector(
            initialGender: _gender,
            onGenderChanged: (gender) {
              setState(() {
                _gender = gender;
              });
            },
          ),
          Spacing.mediumVertical,
          // Donation Type
          ReusableBgCard(
            cardChild: ReusableDropdown<String>(
              label: localizations.donationTypeLabel,
              value: _donationType,
              items: [
                DropdownMenuItem(
                  value: 'whole_blood',
                  child: AdaptiveText(localizations.wholeBloodDonationType),
                ),
                DropdownMenuItem(
                  value: 'double_red_cells',
                  child: AdaptiveText(localizations.doubleRedCellsDonationType),
                ),
                DropdownMenuItem(
                  value: 'platelet',
                  child: AdaptiveText(localizations.plateletDonationType),
                ),
                DropdownMenuItem(
                  value: 'plasma',
                  child: AdaptiveText(localizations.plasmaDonationType),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  _donationType = value!;
                });
              },
            ),
          ),
          Spacing.mediumVertical,
          // Medical Conditions and Travel History
          ReusableBgCard(
            cardChild: Column(
              children: [
                SwitchListTile(
                  title: Text(localizations.medicalConditionsLabel),
                  value: _hasRecentMedicalConditions,
                  onChanged: (bool value) {
                    setState(() {
                      _hasRecentMedicalConditions = value;
                    });
                  },
                ),
                SwitchListTile(
                  title: Text(localizations.travelHistoryLabel),
                  value: _hasTravelHistory,
                  onChanged: (bool value) {
                    setState(() {
                      _hasTravelHistory = value;
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
