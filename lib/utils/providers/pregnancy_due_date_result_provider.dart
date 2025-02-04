import 'package:flutter/material.dart';

class PregnancyDueDateResultProvider with ChangeNotifier {
  DateTime? _lastMenstrualPeriod;
  DateTime? _dueDate;
  int? _gestationalAge;
  String? _trimester;
  String? _calculationMethod;

  // Getters
  DateTime? get lastMenstrualPeriod => _lastMenstrualPeriod;
  DateTime? get dueDate => _dueDate;
  int? get gestationalAge => _gestationalAge;
  String? get trimester => _trimester;
  String? get calculationMethod => _calculationMethod;

  void setResult({
    required DateTime lastMenstrualPeriod,
    required DateTime dueDate,
    required int gestationalAge,
    required String trimester,
    required String calculationMethod,
  }) {
    _lastMenstrualPeriod = lastMenstrualPeriod;
    _dueDate = dueDate;
    _gestationalAge = gestationalAge;
    _trimester = trimester;
    _calculationMethod = calculationMethod;
    notifyListeners();
  }

  void clearResult() {
    _lastMenstrualPeriod = null;
    _dueDate = null;
    _gestationalAge = null;
    _trimester = null;
    _calculationMethod = null;
    notifyListeners();
  }
}
