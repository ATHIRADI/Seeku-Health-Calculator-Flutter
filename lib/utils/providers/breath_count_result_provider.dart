import 'package:flutter/material.dart';

class BreathCountResultProvider with ChangeNotifier {
  int? _breathCount;
  int? _durationSeconds;
  int? _breathsPerMinute;
  String? _category;
  bool? _isAdult;

  // Getters
  int? get breathCount => _breathCount;
  int? get durationSeconds => _durationSeconds;
  int? get breathsPerMinute => _breathsPerMinute;
  String? get category => _category;
  bool? get isAdult => _isAdult;

  void setResult({
    required int breathCount,
    required int durationSeconds,
    required int breathsPerMinute,
    required String category,
    required bool isAdult,
  }) {
    _breathCount = breathCount;
    _durationSeconds = durationSeconds;
    _breathsPerMinute = breathsPerMinute;
    _category = category;
    _isAdult = isAdult;
    notifyListeners();
  }

  void clearResult() {
    _breathCount = null;
    _durationSeconds = null;
    _breathsPerMinute = null;
    _category = null;
    _isAdult = null;
    notifyListeners();
  }
}
