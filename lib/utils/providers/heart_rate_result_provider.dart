import 'package:flutter/material.dart';

class HeartRateResultProvider with ChangeNotifier {
  int? _maxHeartRate;
  int? _age;
  Map<String, int>? _heartRateZones;

  // Getters
  int? get maxHeartRate => _maxHeartRate;
  int? get age => _age;
  Map<String, int>? get heartRateZones => _heartRateZones;

  void setResult({
    required int maxHeartRate,
    required int age,
    required Map<String, int> heartRateZones,
  }) {
    _maxHeartRate = maxHeartRate;
    _age = age;
    _heartRateZones = heartRateZones;
    notifyListeners();
  }

  void clearResult() {
    _maxHeartRate = null;
    _age = null;
    _heartRateZones = null;
    notifyListeners();
  }
}
