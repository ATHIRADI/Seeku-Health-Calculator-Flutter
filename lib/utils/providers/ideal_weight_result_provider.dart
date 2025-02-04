import 'package:flutter/material.dart';
import 'package:seeku_health_calc/widgets/gender_selector.dart';

class IdealWeightResultProvider with ChangeNotifier {
  double? _idealWeight;
  int? _height;
  Gender? _gender;
  String? _idealWeightRange;
  String? _calculationMethod;

  // Getters
  double? get idealWeight => _idealWeight;
  int? get height => _height;
  Gender? get gender => _gender;
  String? get idealWeightRange => _idealWeightRange;
  String? get calculationMethod => _calculationMethod;

  // Setter method
  void setResult({
    required double idealWeight,
    required int height,
    required Gender gender,
    required String calculationMethod,
    required String idealWeightRange,
  }) {
    _idealWeight = idealWeight;
    _height = height;
    _gender = gender;
    _calculationMethod = calculationMethod;
    _idealWeightRange = idealWeightRange;
    notifyListeners();
  }

  // Optional clear method
  void clearResult() {
    _idealWeight = null;
    _height = null;
    _gender = null;
    _calculationMethod = null;
    _idealWeightRange = null;
    notifyListeners();
  }
}
