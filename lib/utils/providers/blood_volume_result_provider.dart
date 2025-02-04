import 'package:flutter/material.dart';
import 'package:seeku_health_calc/widgets/gender_selector.dart';

class BloodVolumeResultProvider with ChangeNotifier {
  double? _bloodVolume;
  int? _weight;
  Gender? _gender;
  String? _category;
  String? _calculationMethod;
  Map<String, dynamic>? _riskFactors;

  // Getters
  double? get bloodVolume => _bloodVolume;
  int? get weight => _weight;
  Gender? get gender => _gender;
  String? get category => _category;
  String? get calculationMethod => _calculationMethod;
  Map<String, dynamic>? get riskFactors => _riskFactors;

  void setResult({
    required double bloodVolume,
    required int weight,
    required Gender gender,
    required String category,
    required String calculationMethod,
    required Map<String, dynamic> riskFactors,
  }) {
    _bloodVolume = bloodVolume;
    _weight = weight;
    _gender = gender;
    _category = category;
    _calculationMethod = calculationMethod;
    _riskFactors = riskFactors;
    notifyListeners();
  }

  void clearResult() {
    _bloodVolume = null;
    _weight = null;
    _gender = null;
    _category = null;
    _calculationMethod = null;
    _riskFactors = null;
    notifyListeners();
  }
}
