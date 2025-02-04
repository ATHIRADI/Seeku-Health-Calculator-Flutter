import 'package:flutter/material.dart';

class OvulationPeriodResultProvider with ChangeNotifier {
  DateTime? _lastMenstrualPeriod;
  DateTime? _ovulationDate;
  List<DateTime>? _fertileWindow;
  int? _cycleDuration;

  // Getters
  DateTime? get lastMenstrualPeriod => _lastMenstrualPeriod;
  DateTime? get ovulationDate => _ovulationDate;
  List<DateTime>? get fertileWindow => _fertileWindow;
  int? get cycleDuration => _cycleDuration;

  void setResult({
    required DateTime lastMenstrualPeriod,
    required DateTime ovulationDate,
    required List<DateTime> fertileWindow,
    required int cycleDuration,
  }) {
    _lastMenstrualPeriod = lastMenstrualPeriod;
    _ovulationDate = ovulationDate;
    _fertileWindow = fertileWindow;
    _cycleDuration = cycleDuration;
    notifyListeners();
  }

  void clearResult() {
    _lastMenstrualPeriod = null;
    _ovulationDate = null;
    _fertileWindow = null;
    _cycleDuration = null;
    notifyListeners();
  }
}
