import 'dart:math';

import 'package:drink/models/app_models/appuser_model.dart';
import 'package:drink/models/app_models/drink_time_model.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class AppVm extends ChangeNotifier {
  // Standard Values
  var _targetWater = 0;
  var _remainingWater = 0;
  var _waterToDrink = 200;
  var _minutesToNotify = 0;
  // Standard Values

  var _goalValue = 0.0;
  var _drinkTimes = <DrinkTime>[];
  var _isLoading = false;

  double get goalValue => _goalValue;
  List<DrinkTime> get drinkTimes => _drinkTimes;
  int get remainingWater => _remainingWater;
  int get targetWater => _targetWater;
  int get waterToDrink => _waterToDrink;
  int get minutesToNotify => _minutesToNotify;
  bool get isLoading => _isLoading;

  // init function
  onInit(final AppUser appUser) {
    initialize(appUser);
  }

  // initialize values
  initialize(final AppUser appUser) async {
    final _goalBox = Hive.box('goals');
    final _drinkTimeBox = Hive.box('drink_time');

    _goalValue = _goalBox.get('goal') ?? 0;
    _drinkTimes =
        _drinkTimeBox.values.map((e) => DrinkTime.fromJson(e)).toList();
    _targetWater = appUser.targetWater;
    _remainingWater =
        max(_targetWater - (_goalValue / 100 * _targetWater).toInt(), 0);
    notifyListeners();
  }

  // on water drink
  onWaterDrink(final double newGoalValue) {
    updateGoalValue(newGoalValue);

    final _list = _drinkTimes;
    final _index = _list.indexWhere((element) =>
        DateTime.fromMillisecondsSinceEpoch(element.time).hour ==
            DateTime.now().hour &&
        DateTime.now()
                .difference(DateTime.fromMillisecondsSinceEpoch(element.time))
                .inMinutes <
            2);
    if (_index != -1) {
      final _drinkTime = DrinkTime(
        time: _list[_index].time,
        value: min(_list[_index].value + 50, 100),
      );
      Hive.box('drink_time').putAt(_index, _drinkTime.toJson());
      _list[_index] = _drinkTime;
    } else {
      final _drinkTime = DrinkTime(
        time: DateTime.now().millisecondsSinceEpoch,
        value: 50,
      );
      Hive.box('drink_time').add(_drinkTime.toJson());
      _list.add(_drinkTime);
    }

    updateDrinkTimes(_list);
  }

  // update value of goalValue
  updateGoalValue(final double newVal) {
    if (_goalValue < 100) {
      _goalValue = newVal;
      Hive.box('goals').put('goal', _goalValue);
      notifyListeners();
    }
  }

  // update value of drink times list
  updateDrinkTimes(final List<DrinkTime> newDrinkTimes) {
    _drinkTimes = newDrinkTimes;
    print(_drinkTimes.map((e) => e.toJson()));
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

  // update value of loader
  updateIsLoading(final bool newVal) {
    _isLoading = newVal;
    notifyListeners();
  }
}
