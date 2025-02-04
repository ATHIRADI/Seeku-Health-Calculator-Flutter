import 'package:flutter/material.dart';
import 'package:seeku_health_calc/widgets/gender_selector.dart';

class BACResultProvider with ChangeNotifier {
  double? _bacLevel;
  double? _weight;
  Gender? _gender;
  double? _alcoholConsumed;
  double? _hours;
  String? _bacCategory;
  List<Map<String, dynamic>>? _bacEffects;

  // Getters
  double? get bacLevel => _bacLevel;
  double? get weight => _weight;
  Gender? get gender => _gender;
  double? get alcoholConsumed => _alcoholConsumed;
  double? get hours => _hours;
  String? get bacCategory => _bacCategory;
  List<Map<String, dynamic>>? get bacEffects => _bacEffects;

  void setResult({
    required double bacLevel,
    required double weight,
    required Gender gender,
    required double alcoholConsumed,
    required double hours,
    required String bacCategory,
    required List<Map<String, dynamic>> bacEffects,
  }) {
    _bacLevel = bacLevel;
    _weight = weight;
    _gender = gender;
    _alcoholConsumed = alcoholConsumed;
    _hours = hours;
    _bacCategory = bacCategory;
    _bacEffects = bacEffects;
    notifyListeners();
  }

  void clearResult() {
    _bacLevel = null;
    _weight = null;
    _gender = null;
    _alcoholConsumed = null;
    _hours = null;
    _bacCategory = null;
    _bacEffects = null;
    notifyListeners();
  }
}
