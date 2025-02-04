import 'package:flutter/material.dart';
import 'package:seeku_health_calc/widgets/gender_selector.dart';

class BloodDonationResultProvider with ChangeNotifier {
  DateTime? _lastDonationDate;
  DateTime? _nextDonationDate;
  int? _daysUntilNextDonation;
  String? _donationType;
  Gender? _gender;
  bool? _isEligible;

  // Getters
  DateTime? get lastDonationDate => _lastDonationDate;
  DateTime? get nextDonationDate => _nextDonationDate;
  int? get daysUntilNextDonation => _daysUntilNextDonation;
  String? get donationType => _donationType;
  Gender? get gender => _gender;
  bool? get isEligible => _isEligible;

  void setResult({
    required DateTime lastDonationDate,
    required DateTime nextDonationDate,
    required int daysUntilNextDonation,
    required String donationType,
    required Gender gender,
    required bool isEligible,
  }) {
    _lastDonationDate = lastDonationDate;
    _nextDonationDate = nextDonationDate;
    _daysUntilNextDonation = daysUntilNextDonation;
    _donationType = donationType;
    _gender = gender;
    _isEligible = isEligible;
    notifyListeners();
  }

  void clearResult() {
    _lastDonationDate = null;
    _nextDonationDate = null;
    _daysUntilNextDonation = null;
    _donationType = null;
    _gender = null;
    _isEligible = null;
    notifyListeners();
  }
}
