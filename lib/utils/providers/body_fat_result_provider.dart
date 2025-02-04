import 'package:flutter/material.dart';
import 'package:seeku_health_calc/widgets/gender_selector.dart';

class BodyFatResultProvider with ChangeNotifier {
  double? _bodyFatPercentage;
  int? _age;
  int? _height;
  int? _weight;
  Gender? _gender;
  String? _bodyFatCategory;
  String? _calculationMethod;

  // Getters
  double? get bodyFatPercentage => _bodyFatPercentage;
  int? get age => _age;
  int? get height => _height;
  int? get weight => _weight;
  Gender? get gender => _gender;
  String? get bodyFatCategory => _bodyFatCategory;
  String? get calculationMethod => _calculationMethod;

  void setResult({
    required double bodyFatPercentage,
    required int age,
    required int height,
    required int weight,
    required Gender gender,
    required String bodyFatCategory,
    required String calculationMethod,
  }) {
    _bodyFatPercentage = bodyFatPercentage;
    _age = age;
    _height = height;
    _weight = weight;
    _gender = gender;
    _bodyFatCategory = bodyFatCategory;
    _calculationMethod = calculationMethod;
    notifyListeners();
  }

  void clearResult() {
    _bodyFatPercentage = null;
    _age = null;
    _height = null;
    _weight = null;
    _gender = null;
    _bodyFatCategory = null;
    _calculationMethod = null;
    notifyListeners();
  }
}
