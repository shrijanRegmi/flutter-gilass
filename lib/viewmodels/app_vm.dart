import 'dart:math';

import 'package:drink/models/app_models/drink_time_model.dart';
import 'package:flutter/material.dart';

class AppVm extends ChangeNotifier {
  // Standard Values
  static var _targetWater = 0;
  var _remainingWater = _targetWater;
  var _waterToDrink = 200;
  var _minutesToNotify = 0;
  // Standard Values

  var _goalValue = 0.0;
  var _drinkTimes = <DrinkTime>[];

  double get goalValue => _goalValue;
  List<DrinkTime> get drinkTimes => _drinkTimes;
  int get remainingWater => _remainingWater;
  int get targetWater => _targetWater;
  int get waterToDrink => _waterToDrink;
  int get minutesToNotify => _minutesToNotify;

  // on water drink
  onWaterDrink(final double newGoalValue) {
    updateGoalValue(newGoalValue);

    final _list = _drinkTimes;
    final _index = _list.indexWhere((element) =>
        DateTime.fromMillisecondsSinceEpoch(element.time).hour ==
        DateTime.now().hour);
    if (_index != -1) {
      _list[_index] = DrinkTime(
        time: _list[_index].time,
        value: min(_list[_index].value + 50, 100),
      );
    } else {
      _list.add(DrinkTime(
        time: DateTime.now().millisecondsSinceEpoch,
        value: 50,
      ));
    }

    updateDrinkTimes(_list);
  }

  // update value of goalValue
  updateGoalValue(final double newVal) {
    if (_goalValue < 100) {
      _goalValue = newVal;
      notifyListeners();
    }
  }

  // update value of drink times list
  updateDrinkTimes(final List<DrinkTime> newDrinkTimes) {
    _drinkTimes = newDrinkTimes;
    notifyListeners();
  }

  // update value of remaining
  updateRemainingWater(final int newVal) {
    if (_goalValue >= 100) {
      _remainingWater = 0;
      notifyListeners();
    } else {
      if (newVal >= 0) {
        _remainingWater = newVal;
        notifyListeners();
      }
    }
  }

  // update value of target water intake
  updateTargetValue(final double newVal) {
    _targetWater = int.parse('${newVal.toStringAsFixed(0)}');
    notifyListeners();
  }

  // update value of minutes to notify
  updateMinutesToNotify(final int newVal) {
    _minutesToNotify = newVal;
    notifyListeners();
  }
}
