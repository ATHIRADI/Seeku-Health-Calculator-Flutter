import 'package:flutter/material.dart';
import 'package:seeku_health_calc/widgets/gender_selector.dart';

class CaloriesResultProvider with ChangeNotifier {
  double? _calorieNeeds;
  int? _height;
  int? _weight;
  int? _age;
  Gender? _gender;
  String? _goal;
  double? _activityLevel;

  // Getters
  double? get calorieNeeds => _calorieNeeds;
  int? get height => _height;
  int? get weight => _weight;
  int? get age => _age;
  Gender? get gender => _gender;
  String? get goal => _goal;
  double? get activityLevel => _activityLevel;

  void setResult({
    required double calorieNeeds,
    required int height,
    required int weight,
    required int age,
    required Gender gender,
    required String goal,
    required double activityLevel,
  }) {
    _calorieNeeds = calorieNeeds;
    _height = height;
    _weight = weight;
    _age = age;
    _gender = gender;
    _goal = goal;
    _activityLevel = activityLevel;
    notifyListeners();
  }

  void clearResult() {
    _calorieNeeds = null;
    _height = null;
    _weight = null;
    _age = null;
    _gender = null;
    _goal = null;
    _activityLevel = null;
    notifyListeners();
  }
}
