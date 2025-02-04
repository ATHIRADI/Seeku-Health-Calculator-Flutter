import 'package:flutter/material.dart';
import 'package:seeku_health_calc/utils/calculator_util.dart';
import 'package:seeku_health_calc/widgets/gender_selector.dart';

class BMIResultProvider with ChangeNotifier {
  double? _bmiResult;
  int? _weight;
  int? _height;
  int? _age;
  Gender? _gender;
  String? _bmiCategory;

  // Getters
  double? get bmiResult => _bmiResult;
  int? get weight => _weight;
  int? get height => _height;
  int? get age => _age;
  Gender? get gender => _gender;
  String? get bmiCategory => _bmiCategory;

  // New getter for BMI category color
  Color get bmiCategoryColor {
    if (_bmiResult != null) {
      return CalculatorUtil.getBMICategoryColor(_bmiResult!);
    }
    return Colors.black; // Default color if no result
  }

  // New getter for healthy weight range
  String? healthyWeightRange(BuildContext context) {
    if (_height != null && _age != null && _gender != null) {
      return CalculatorUtil.calculateHealthyWeightRange(
          context, _height!, _age!, _gender!);
    }
    return null; // Return null if not available
  }

  // Setter method
  void setResult({
    required double bmiResult,
    required int weight,
    required int height,
    required int age,
    required Gender gender,
    required String bmiCategory,
  }) {
    _bmiResult = bmiResult;
    _weight = weight;
    _height = height;
    _age = age;
    _gender = gender;
    _bmiCategory = bmiCategory;
    notifyListeners();
  }

  // Optional clear method
  void clearResult() {
    _bmiResult = null;
    _weight = null;
    _height = null;
    _age = null;
    _gender = null;
    _bmiCategory = null;
    notifyListeners();
  }
}
