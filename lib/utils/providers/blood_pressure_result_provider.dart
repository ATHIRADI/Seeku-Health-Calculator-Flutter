import 'package:flutter/material.dart';

class BloodPressureResultProvider with ChangeNotifier {
  int? _systolic;
  int? _diastolic;
  String? _category;
  String? _risk;
  Color? _categoryColor;

  // Getters
  int? get systolic => _systolic;
  int? get diastolic => _diastolic;
  String? get category => _category;
  String? get risk => _risk;
  Color? get categoryColor => _categoryColor;

  void setResult({
    required int systolic,
    required int diastolic,
    required String category,
    required String risk,
    required Color categoryColor,
  }) {
    _systolic = systolic;
    _diastolic = diastolic;
    _category = category;
    _risk = risk;
    _categoryColor = categoryColor;
    notifyListeners();
  }

  void clearResult() {
    _systolic = null;
    _diastolic = null;
    _category = null;
    _risk = null;
    _categoryColor = null;
    notifyListeners();
  }
}
